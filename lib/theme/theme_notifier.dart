import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  // state initialization with ThemeMode.system, follows the device's theme.
  ThemeModeNotifier() : super(ThemeMode.system);

  // A method to toggle the theme mode.
  void setMode(ThemeMode mode) {
    state = mode;
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((
  ref,
) {
  return ThemeModeNotifier();
});

// Accent Color Notifier
// control user selected accent color
class AccentColorNotifier extends StateNotifier<Color> {
  // initialize state with first accent on list
  AccentColorNotifier() : super(themeAccentColors[0]);

  // method to update color
  void setColor(Color color) {
    state = color;
  }
}

final accentColorProvider = StateNotifierProvider<AccentColorNotifier, Color>((
  ref,
) {
  return AccentColorNotifier();
});

const List<Color> themeAccentColors = [
  Color(0xFF009688),
  Color(0xFFE91E63),
  Color(0xFF9C27B0),
];
