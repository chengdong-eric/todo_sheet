import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/providers/todo_list_provider.dart';
import 'package:todo_list/components/empty_todo_placeholder.dart';
import 'package:todo_list/components/home_dot_painter.dart';
import 'package:todo_list/components/todo_item.dart';
import 'package:todo_list/home_page.dart';

class TodoListSection extends ConsumerWidget {
  const TodoListSection({super.key});

  /// Starts editing a to-do item in the list.
  ///
  /// If [index] is provided, sets the editing index to that value.
  /// If [index] is null, appends a new empty to-do item to the list and sets the editing index to the new item.
  ///
  /// - [index]: (Optional) The index of the to-do item to edit. If null, a new item is added.
  void _startNewTodo(WidgetRef ref, {int? index}) {
    final todoNotifier = ref.read(todoListProvider.notifier);
    final currentlyEditingId = ref.read(editingIdProvider);

    if (currentlyEditingId != null) {
      todoNotifier.saveAndCleanup(currentlyEditingId);
    }

    final newTodoId = todoNotifier.addTodo();

    ref.read(editingIdProvider.notifier).state = newTodoId;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    final brightness = Theme.of(context).brightness;

    final dotColor = brightness == Brightness.light
        ? Colors.grey.shade100
        : Colors.transparent;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _startNewTodo(ref),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: DotPainter(spacing: 40, dotRadius: 5, color: dotColor),
                child: Container(),
              ),
            ),
            if (todos.isEmpty)
              const IgnorePointer(child: EmptyTodoPlaceholder())
            else
              SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: todos.length,
                      itemBuilder: (c, i) {
                        final todo = todos[i];
                        return TodoItem(todoId: todo.id);
                      },
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
