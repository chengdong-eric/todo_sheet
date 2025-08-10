import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:todo_list/home_page.dart';

class TodoItem extends ConsumerWidget {
  final int index;
  final VoidCallback onTap;
  const TodoItem({required this.index, required this.onTap, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    final isEditing = ref.watch(editingIndexProvider) == index;

    if (isEditing) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Enter task...",
            border: UnderlineInputBorder(),
          ),
          onSubmitted: (value) {
            ref.read(todoListProvider.notifier).update((list) {
              list[index] = value;
              return [...list];
            });
            ref.read(editingIndexProvider.notifier).state = null;
          },
        ),
      );
    }

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.check_box_outline_blank),
          title: Text(
            todos[index],
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: IconButton(
            icon: const SFIcon(SFIcons.sf_info_circle),
            onPressed: () {
              // TODO: Navigate to DetailPage
            },
          ),
          // Direct tap on tile to edit
          onTap: () {
            // TODO: Implement inline editing logic
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(height: 1, thickness: 1, color: Colors.grey[200]),
        ),
      ],
    );
  }
}
