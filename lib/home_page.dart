import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:todo_list/providers/todo_list_provider.dart';
import 'package:todo_list/components/editable_title.dart';
import 'package:todo_list/components/todo_list_section.dart';
import 'package:todo_list/screens/settings/settings.dart';
import 'package:todo_list/utils/clear_list_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
                  const EditableTitle(),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingsPage(),
                                ),
                              );
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
                          icon: const SFIcon(SFIcons.sf_ellipsis_circle),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(), // The accent-colored underline
            // --- To-Do List View ---
            const TodoListSection(),
          ],
        ),
      ),
      // --- Floating Action Button ---
      floatingActionButton: FloatingActionButton(
        onPressed: () => showClearListDialog(context, ref),
        child: const SFIcon(SFIcons.sf_eraser_fill, fontSize: 24),
      ),
    );
  }
}
