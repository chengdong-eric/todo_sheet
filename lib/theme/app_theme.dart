import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Base Colors
HSLColor baseGrey = HSLColor.fromAHSL(1.0, 38, 0.06, 1.0);
HSLColor baseRed = HSLColor.fromAHSL(1.0, 0, 0.69, 1.0);
HSLColor baseGreen = HSLColor.fromAHSL(1.0, 97, 0.61, 1.0);
HSLColor baseBlue = HSLColor.fromAHSL(1.0, 211, 0.39, 1.0);
HSLColor baseYellow = HSLColor.fromAHSL(1.0, 41, 1.0, 1.0);

// Priority Colors - Light Theme Shades
Color redLight = baseRed.withLightness(0.80).toColor();
Color greenLight = baseGreen.withLightness(0.85).toColor();
Color blueLight = baseBlue.withLightness(0.85).toColor();
Color yellowLight = baseYellow.withLightness(0.85).toColor();

// Priority Colors - Dark Theme Shades
Color redDark = baseRed.withLightness(0.70).toColor();
Color greenDark = baseGreen.withLightness(0.70).toColor();
Color blueDark = baseBlue.withLightness(0.64).toColor();
Color yellowDark = baseYellow.withLightness(0.70).toColor();

// Shades
Color greyLightest = baseGrey.withLightness(0.93).toColor();
Color greyLighter = baseGrey.withLightness(0.86).toColor();
Color greyLight = baseGrey.withLightness(0.80).toColor();
Color greyDark = baseGrey.withLightness(0.75).toColor();
Color greyDarker = baseGrey.withLightness(0.70).toColor();

Color redLightest = baseRed.withLightness(0.88).toColor();
Color green = baseGreen.withLightness(0.78).toColor();
Color blue = baseBlue.withLightness(0.76).toColor();
Color yellowLightest = baseYellow.withLightness(0.92).toColor();
Color yellow = baseYellow.withLightness(0.80).toColor();

enum AppThemeColor { deepBlue, burntOrange, forestGreen }

const deepBlueColor = Color(0xFF007AFF);
const burntOrangeColor = Color(0xFFE67E22);
const forestGreenColor = Color(0xFF27AE60);

@immutable
class AppCustomColors extends ThemeExtension<AppCustomColors> {
  const AppCustomColors({required this.priorityRed});
}

// --- Light Theme ---
ThemeData getLightModeTheme(AppThemeColor accentColor) {
  final Color selectedAccentColor = switch (accentColor) {
    AppThemeColor.deepBlue => deepBlueColor,
    AppThemeColor.burntOrange => burntOrangeColor,
    AppThemeColor.forestGreen => forestGreenColor,
  };

  return ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      surface: Colors.white,
      onSurface: Color(0xFF333333),
    ),
    iconTheme: IconThemeData(color: selectedAccentColor),
    dividerColor: selectedAccentColor.withValues(alpha: 0.5),
    
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.
    )
  );
}
