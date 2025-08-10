import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:todo_list/components/empty_todo_placeholder.dart';
import 'package:todo_list/components/home_dot_painter.dart';
import 'package:todo_list/components/todo_item.dart';
import 'package:todo_list/home_page.dart';

class TodoListSection extends ConsumerWidget {
  const TodoListSection({super.key});
  void _startEditing(WidgetRef ref, {int? index}) {
    final list = ref.read(todoListProvider);
    final target = index ?? list.length;
    if (index == null) {
      ref.read(todoListProvider.notifier).state = [...list, ''];
    }
    ref.read(editingIndexProvider.notifier).state = target;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _startEditing(ref),
        child: CustomPaint(
          painter: DotPainter(
            spacing: 40,
            dotRadius: 5,
            color: Colors.grey.shade100,
          ),
          child: todos.isEmpty
              // Empty State Placeholder
              ? EmptyTodoPlaceholder()
              // List of Tasks
              : ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (c, i) => TodoItem(
                    index: i,
                    onTap: () => _startEditing(ref, index: 1),
                  ),
                ),
        ),
      ),
    );
  }
}
