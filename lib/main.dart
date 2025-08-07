import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/screens/home/todo_home.dart';
import 'package:todo_list/theme/app_theme.dart';
import 'package:todo_list/theme/theme_notifier.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch providers for change
    final themeMode = ref.watch(themeModeProvider);
    final accentColor = ref.watch(accentColorProvider);

    // generate themes dynamically
    final lightTheme = getAppTheme(Brightness.light, accentColor);
    final darkTheme = getAppTheme(Brightness.dark, accentColor);

    return MaterialApp(
      title: 'Todo sheet',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const TodoHome(),
    );
  }
}
