import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:todo_list/Providers/todo_list_provider.dart';
import 'package:todo_list/home_page.dart';

class TodoItem extends ConsumerStatefulWidget {
  final String todoId;

  const TodoItem({required this.todoId, super.key});

  @override
  ConsumerState<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends ConsumerState<TodoItem> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final todo = ref
        .read(todoListProvider)
        .firstWhere((t) => t.id == widget.todoId);
    _controller = TextEditingController(text: todo.description);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    final notifier = ref.read(todoListProvider.notifier);
    final currentlyEditingId = ref.read(editingIdProvider);

    if (currentlyEditingId != null && currentlyEditingId != widget.todoId) {
      notifier.saveAndCleanup(currentlyEditingId);
    }

    ref.read(editingIdProvider.notifier).state = widget.todoId;
  }

  @override
  Widget build(BuildContext context) {
    final todo = ref.watch(
      todoListProvider.select((todos) {
        return todos.firstWhere(
          (t) => t.id == widget.todoId,
          orElse: () => throw Exception('Todo not found'),
        );
      }),
    );
    final isEditing = ref.watch(editingIdProvider) == widget.todoId;

    if (isEditing) {
      return ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (v) => ref
              .read(todoListProvider.notifier)
              .toggleCompletion(widget.todoId),
        ),
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Add new task...',
            border: InputBorder.none,
          ),
          onChanged: (newText) {
            ref
                .read(todoListProvider.notifier)
                .updateDescription(widget.todoId, newText);
          },
          onSubmitted: (v) {
            ref.read(todoListProvider.notifier).saveAndCleanup(widget.todoId);
            ref.read(editingIdProvider.notifier).state = null;
          },
        ),
      );
    }

    return ListTile(
      onTap: _handleTap,
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (v) =>
            ref.read(todoListProvider.notifier).toggleCompletion(widget.todoId),
      ),
      title: Text(
        todo.description,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          color: todo.isCompleted ? Colors.grey : null,
        ),
      ),
      trailing: IconButton(
        icon: const SFIcon(SFIcons.sf_info_circle),
        onPressed: () {
          // TODO: Navigate to DetailPage
        },
      ),
    );
  }
}
