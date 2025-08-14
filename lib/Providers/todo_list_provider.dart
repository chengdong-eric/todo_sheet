import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/todo_model.dart';

// These providers remain unchanged
final titleProvider = StateProvider<String>((ref) => "My Todos");
final isTitleEditingProvider = StateProvider<bool>((ref) => false);
final editingIdProvider = StateProvider<String?>((ref) => null);

class TodoListNotifier extends StateNotifier<List<Todo>> {
  // The constructor now calls _loadTodos to fetch data when the app starts.
  TodoListNotifier() : super([]) {
    _loadTodos();
  }

  static const _todosKey = 'todos';

  /// Loads the list of todos from shared preferences.
  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> todoListJson = prefs.getStringList(_todosKey) ?? [];
    state = todoListJson
        .map((jsonString) => Todo.fromJson(json.decode(jsonString)))
        .toList();
  }

  /// Saves the current list of todos to shared preferences.
  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> todoListJson = state
        .map((todo) => json.encode(todo.toJson()))
        .toList();
    await prefs.setStringList(_todosKey, todoListJson);
  }

  String addTodo() {
    final newTodo = Todo(description: '');
    state = [...state, newTodo];
    _saveTodos();
    return newTodo.id;
  }

  void toggleCompletion(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(isCompleted: !todo.isCompleted)
        else
          todo,
    ];
    _saveTodos();
  }

  void updateDescription(String id, String description) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(description: description) else todo,
    ];
    _saveTodos();
  }

  void saveAndCleanup(String id) {
    final todo = state.firstWhere((t) => t.id == id);
    if (todo.description.trim().isEmpty) {
      state = state.where((t) => t.id != id).toList();
      _saveTodos();
    }
  }

  /// Clears all todos from the list and storage.
  Future<void> clearAll() async {
    state = [];
    await _saveTodos();
  }

  /// Restores the list from a backup (used for the Undo action).
  Future<void> restore(List<Todo> backup) async {
    state = backup;
    await _saveTodos();
  }
}

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>(
  (ref) => TodoListNotifier(),
);
