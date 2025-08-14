import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/providers/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final accentColor = ref.watch(accentColorProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Theme'),
            trailing: DropdownButton<ThemeMode>(
              value: themeMode,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System'),
                ),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              ],
              onChanged: (mode) {
                if (mode != null) {
                  ref.read(themeModeProvider.notifier).setMode(mode);
                }
              },
            ),
          ),
          ListTile(
            title: const Text('Accent Color'),
            trailing: DropdownButton<Color>(
              value: accentColor,
              items: themeAccentColors.map((namedColor) {
                return DropdownMenuItem(
                  value: namedColor.color,
                  child: Row(
                    children: [
                      Container(width: 20, height: 20, color: namedColor.color),
                      const SizedBox(width: 8),
                      Text(namedColor.name),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (color) {
                if (color != null) {
                  ref.read(accentColorProvider.notifier).setColor(color);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
