import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/Providers/todo_list_provider.dart';
import 'package:todo_list/home_page.dart';

Future<void> showClearListDialog(BuildContext context, WidgetRef ref) async {
  final backup = ref.read(todoListProvider);

  final shouldClear = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Start a New Sheet?'),
        content: const Text('This will clear all items from the current list'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text(
              'Clear',
              style: TextStyle(color: Color(0xFFD62C1A)),
            ),
          ),
        ],
      );
    },
  );

  if (shouldClear == true) {
    ref.read(todoListProvider.notifier).state = [];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('List Cleared.'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            ref.read(todoListProvider.notifier).state = backup;
          },
        ),
      ),
    );
  }
}
