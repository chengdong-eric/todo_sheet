import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:url_launcher/url_launcher.dart';

// Dummy providers for now. In a real app, these would manage a list of Todo objects.
final todoListProvider = StateProvider<List<String>>((ref) => []);
final listTitleProvider = StateProvider<String>((ref) => "Today");

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  // Method to show the 'Start New Sheet' confirmation dialog
  void _showClearConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Start a New Sheet?'),
          content: const Text(
            'This will clear all items from the current list.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: Text(
                'Clear',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog

                // Backup the current list for the Undo action
                final backup = ref.read(todoListProvider);

                // Clear the list
                ref.read(todoListProvider.notifier).state = [];

                // Show a SnackBar with an Undo button
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('List cleared.'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        // Restore the backup if Undo is tapped
                        ref.read(todoListProvider.notifier).state = backup;
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listTitle = ref.watch(listTitleProvider);
    final todos = ref.watch(todoListProvider);

    return Scaffold(
      // Dotted background pattern (simple implementation using a repeating image)
      // For this to work, create a 10x10 png image of a single dot
      // and add it to an `assets` folder.
      // body: Container(
      //   decoration: const BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage("assets/dot.png"),
      //       repeat: ImageRepeat.repeat,
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            // --- Custom App Bar ---
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // --- Editable Title ---
                  Row(
                    children: [
                      Text(
                        listTitle,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.edit, color: Colors.grey[400], size: 24),
                    ],
                  ),
                  // --- Action Buttons ---
                  Row(
                    children: [
                      // Sort Button
                      PullDownButton(
                        itemBuilder: (context) => [
                          PullDownMenuItem.selectable(
                            title: 'Default',
                            onTap: () {},
                            selected: true,
                          ),
                          PullDownMenuItem.selectable(
                            title: 'Alphabetical',
                            onTap: () {},
                            selected: false,
                          ),
                          PullDownMenuItem.selectable(
                            title: 'By Creation Time',
                            onTap: () {},
                            selected: false,
                          ),
                        ],
                        buttonBuilder: (context, showMenu) => IconButton(
                          onPressed: showMenu,
                          icon: const SFIcon(
                            SFIcons.sf_arrow_up_arrow_down_circle,
                          ),
                        ),
                      ),
                      // More Button
                      PullDownButton(
                        itemBuilder: (context) => [
                          PullDownMenuItem(
                            title: 'Feedback',
                            icon: SFIcons.sf_exclamationmark_bubble,
                            onTap: () async {
                              final Uri emailLaunchUri = Uri(
                                scheme: 'mailto',
                                path: 'ericdc3365@outlook.com',
                                query: 'subject=Feedback for todo sheet App',
                              );
                              if (await canLaunchUrl(emailLaunchUri)) {
                                await launchUrl(emailLaunchUri);
                              }
                            },
                          ),
                          PullDownMenuItem(
                            title: 'Settings',
                            icon: SFIcons.sf_gear,
                            onTap: () {
                              // TODO: Navigate to SettingsPage
                            },
                          ),
                          PullDownMenuItem(
                            title: 'Print',
                            icon: SFIcons.sf_printer,
                            onTap: () {
                              // TODO: Implement Print functionality
                            },
                          ),
                        ],
                        buttonBuilder: (context, showMenu) => IconButton(
                          onPressed: showMenu,
                          icon: SFIcon(SFIcons.sf_ellipsis_circle),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(), // The accent-colored underline
            // --- To-Do List View ---
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Add a new task when tapping on the empty space
                  ref
                      .read(todoListProvider.notifier)
                      .update(
                        (state) => [...state, "New Item ${state.length + 1}"],
                      );
                },
                child: todos.isEmpty
                    // Empty State Placeholder
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_box_outline_blank,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Tap here to add a task",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      )
                    // List of Tasks
                    : ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: const Icon(
                                  Icons.check_box_outline_blank,
                                ),
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Colors.grey[200],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      // --- Floating Action Button ---
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showClearConfirmationDialog(context, ref),
        child: const SFIcon(SFIcons.sf_eraser_fill, fontSize: 24),
      ),
    );
  }
}
