import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/theme/theme_notifier.dart';

class TodoHome extends ConsumerWidget {
  const TodoHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // access current theme's properties from Material App provider consumption
    final textTheme = Theme.of(context).textTheme;
    final iconTheme = Theme.of(context).iconTheme;

    // current theme mode
    final currentMode = ref.watch(themeModeProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'My Todo',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
                        child: Icon(icon),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 40,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(title: Text('List item number $index')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
            heroTag: 'new_item',
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.remove),
            heroTag: 'delete',
          ),
        ],
      ),
    );
  }
}
