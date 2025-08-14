import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- State Notifiers with Persistence ---

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  static const _themeModeKey = 'themeMode';

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString(_themeModeKey);
    state = ThemeMode.values.firstWhere(
      (e) => e.name == themeName,
      orElse: () => ThemeMode.system,
    );
  }

  void setMode(ThemeMode mode) {
    if (state != mode) {
      state = mode;
      _saveThemeMode();
    }
  }

  Future<void> _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, state.name);
  }
}

class AccentColorNotifier extends StateNotifier<Color> {
  AccentColorNotifier() : super(themeAccentColors.first.color) {
    _loadAccentColor();
  }

  static const _accentColorKey = 'accentColor';

  Future<void> _loadAccentColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt(_accentColorKey);
    if (colorValue != null) {
      state = Color(colorValue);
    }
  }

  void setColor(Color color) {
    if (state.value != color.value) {
      state = color;
      _saveAccentColor();
    }
  }

  Future<void> _saveAccentColor() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_accentColorKey, state.value);
  }
}

// --- Providers ---

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);
final accentColorProvider = StateNotifierProvider<AccentColorNotifier, Color>(
  (ref) => AccentColorNotifier(),
);

// --- Theme Data (Unchanged) ---
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
  // ... (This function remains unchanged)
  final bool isLightMode = brightness == Brightness.light;
  final Color scaffoldBackgroundColor = isLightMode
      ? const Color(0xFFF9F9F9)
      : const Color(0xFF1C1C1E);
  final Color textColor = isLightMode
      ? Colors.black87
      : Colors.white.withAlpha(217);

  return ThemeData(
    fontFamily: 'National Park',
    brightness: brightness,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    primaryColor: accentColor,
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      bodyLarge: TextStyle(fontSize: 17, color: textColor),
      bodyMedium: TextStyle(fontSize: 17, color: Colors.grey[400]),
      titleMedium: TextStyle(
        fontFamily: 'National Park',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.grey[300],
      foregroundColor: accentColor,
      elevation: 1,
      highlightElevation: 2,
      shape: const CircleBorder(),
    ),
    dividerTheme: DividerThemeData(
      color: accentColor,
      thickness: 1.5,
      space: 1,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: isLightMode ? Colors.white : const Color(0xFF2C2C2D),
    ),
  );
}
