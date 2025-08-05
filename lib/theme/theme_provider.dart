import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class ThemeSettings {
  final ThemeMode themeMode;
  final MaterialColor accentColor;

  const ThemeSettings({required this.themeMode, required this.accentColor});

  // helper method to replace old themedata with new data and update the state
  ThemeSettings copyWith({ThemeMode? themeMode, MaterialColor? accentColor}) {
    return ThemeSettings(
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
    );
  }
}

// Notifier class
// Contains logic to update the state
class ThemeNotifier extends Notifier<ThemeSettings> {
  @override
  ThemeSettings build() {
    return ThemeSettings(
      themeMode: ThemeMode.system,
      accentColor: AppColors.themeColors.first,
    );
  }
}
