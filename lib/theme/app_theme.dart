import 'package:flutter/material.dart';

HSLColor baseGrey = HSLColor.fromAHSL(1.0, 38, 0.06, 1.0);
HSLColor baseRed = HSLColor.fromAHSL(1.0, 0, 0.69, 1.0);
HSLColor baseGreen = HSLColor.fromAHSL(1.0, 97, 0.61, 1.0);
HSLColor baseBlue = HSLColor.fromAHSL(1.0, 211, 0.39, 1.0);
HSLColor baseYellow = HSLColor.fromAHSL(1.0, 41, 1.0, 1.0);

Color greyLightest = baseGrey.withLightness(0.93).toColor();
Color greyLighter = baseGrey.withLightness(0.86).toColor();
Color greyLight = baseGrey.withLightness(0.80).toColor();
Color greyDark = baseGrey.withLightness(0.75).toColor();
Color greyDarker = baseGrey.withLightness(0.70).toColor();

Color redLightest = baseRed.withLightness(0.88).toColor();
Color redLight = baseRed.withLightness(0.80).toColor();
Color redDark = baseRed.withLightness(0.70).toColor();

Color greenLight = baseGreen.withLightness(0.85).toColor();
Color green = baseGreen.withLightness(0.78).toColor();
Color greenDark = baseGreen.withLightness(0.70).toColor();

Color blueLight = baseBlue.withLightness(0.85).toColor();
Color blue = baseBlue.withLightness(0.76).toColor();
Color blueDark = baseBlue.withLightness(0.64).toColor();

Color yellowLightest = baseYellow.withLightness(0.92).toColor();
Color yellowLight = baseYellow.withLightness(0.85).toColor();
Color yellow = baseYellow.withLightness(0.80).toColor();
Color yellowDark = baseYellow.withLightness(0.70).toColor();

// Function to build theme, takes brightness(light/dark) and an accent color,
// return complete themeData Object
ThemeData getAppTheme(Brightness brightness, Color accentColor) {
  final bool isLightMode = brightness == Brightness.light;
  final Color backgroundColor = isLightMode
      ? const Color(0xFFF5F5F5)
      : const Color(0xFF121212);
  final Color textColor = isLightMode
      ? const Color(0xFF333333)
      : Colors.white70;
  final Color appBarIconColor = isLightMode
      ? const Color(0xFF555555)
      : Colors.white70;

  return ThemeData(
    brightness: brightness,
    scaffoldBackgroundColor: backgroundColor,
    iconTheme: IconThemeData(color: accentColor),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: appBarIconColor),
    ),
    fontFamily: 'National Park',

    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      bodyLarge: TextStyle(fontSize: 18, color: textColor),
      labelLarge: TextStyle(fontSize: 16, color: textColor),
    ),

    popupMenuTheme: PopupMenuThemeData(
      color: isLightMode ? Colors.white : const Color(0xFF2C2C2C),
      textStyle: TextStyle(
        fontFamily: 'National Park',
        fontSize: 16,
        color: textColor,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      foregroundColor: Colors.black,
    ),
  );
}
