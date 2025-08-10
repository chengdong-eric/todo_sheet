// State Notifiers
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system);
  void setMode(ThemeMode mode) => state = mode;
}

class AccentColorNotifier extends StateNotifier<Color> {
  AccentColorNotifier() : super(themeAccentColors.first.color);
  void setColor(Color color) => state = color;
}

// Providers
final themeModeProvider = StateNotifierProvider((ref) => ThemeModeNotifier());
final accentColorProvider = StateNotifierProvider(
  (ref) => AccentColorNotifier(),
);

class NamedColor {
  final String name;
  final Color color;
  const NamedColor(this.name, this.color);
}

const List<NamedColor> themeAccentColors = [
  NamedColor('Graphite', Color(0xFF8E8E93)),
  NamedColor('Teal', Color(0xFF009688)),
  NamedColor('Indigo', Color(0xFF5856D6)),
  NamedColor('Pink', Color(0xFFE91E63)),
  NamedColor('Orange', Color(0xFFFF9500)),
];

ThemeData getAppTheme(Brightness brightness, Color accentColor) {
  final bool isLightMode = brightness == Brightness.light;
  final Color scaffoldBackgroundColor = isLightMode
      ? const Color(0xFFF9F9F9)
      : const Color(0xFF1C1C1E);
  final Color textColor = isLightMode
      ? Colors.black87
      : Colors.white.withValues(alpha: 0.85);
  return ThemeData(
    fontFamily: 'National Park',
    brightness: brightness,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    primaryColor: accentColor,
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      bodyLarge: TextStyle(fontSize: 17, color: textColor),
      bodyMedium: TextStyle(fontSize: 17, color: Colors.grey[400]),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.grey[300],
      foregroundColor: accentColor, // The icon color will be the accent color
      elevation: 1,
      highlightElevation: 2,
      shape: const CircleBorder(),
    ),
    // Theme for the underline and dividers
    dividerTheme: DividerThemeData(
      color: accentColor,
      thickness: 1.5,
      space: 1,
    ),
    // Theme for the dialogs
    dialogTheme: DialogThemeData(
      backgroundColor: isLightMode ? Colors.white : const Color(0xFF2C2C2D),
    ),
  );
}
