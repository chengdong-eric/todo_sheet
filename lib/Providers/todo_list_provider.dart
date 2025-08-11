import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  String addTodo() {
    final newTodo = Todo(id: Uuid().v4(), description: '');
    state = [...state, newTodo];
    return newTodo.id;
  }

  void updateDescription(String id, String newDescription) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(description: newDescription) else todo,
    ];
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void toggleCompletion(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(isCompleted: !todo.isCompleted)
        else
          todo,
    ];
  }

  void saveAndCleanup(String id) {
    final todo = state.firstWhere((t) => t.id == id);
    if (todo.description.trim().isEmpty) {
      removeTodo(id);
    }
  }
}

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>(
  (ref) => TodoListNotifier(),
);
