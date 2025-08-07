import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// --- State Notifiers ---

// Manages the app's brightness (System, Light, Dark)
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system);
  void setMode(ThemeMode mode) => state = mode;
}

// Manages the user-selected accent color
class AccentColorNotifier extends StateNotifier<Color> {
  AccentColorNotifier()
    : super(themeAccentColors.first.color); // Default to the first color
  void setColor(Color color) => state = color;
}

// --- Providers ---

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);
final accentColorProvider = StateNotifierProvider<AccentColorNotifier, Color>(
  (ref) => AccentColorNotifier(),
);

// --- Theme Data ---

// A simple data class to hold our named colors
class NamedColor {
  final String name;
  final Color color;
  const NamedColor(this.name, this.color);
}

// List of user-selectable theme colors
const List<NamedColor> themeAccentColors = [
  NamedColor('Graphite', Color(0xFF8E8E93)),
  NamedColor('Teal', Color(0xFF009688)),
  NamedColor('Indigo', Color(0xFF5856D6)),
  NamedColor('Pink', Color(0xFFE91E63)),
  NamedColor('Orange', Color(0xFFFF9500)),
];

/// A factory that builds our app's theme based on brightness and accent color.
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
    // Define a text theme for consistent typography
    textTheme: TextTheme(
      // For the main title "My Todo"
      headlineMedium: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      // For the task item text
      bodyLarge: TextStyle(fontSize: 17, color: textColor),
      // For placeholder text
      bodyMedium: TextStyle(fontSize: 17, color: Colors.grey[400]),
      // For detail page labels
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    ),
    // Theme for the "Start New Sheet" FAB
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
