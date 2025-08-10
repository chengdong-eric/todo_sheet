import 'package:flutter/material.dart';

class EmptyTodoPlaceholder extends StatelessWidget {
  const EmptyTodoPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Icon(Icons.check_box_outline_blank, color: Colors.grey[300]),
            const SizedBox(width: 12),
            Text(
              "Tap to add a task",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[200]),
            ),
          ],
        ),
      ),
    );
  }
}
