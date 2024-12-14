// import 'package:appecg/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static Color accessColor = const Color(0xff0A4E74);
  static Color actionColor = const Color(0xff69B9E6);

  /// light theme
  static Color backgroundColorLight = Colors.white;
  static Color textColorLight = const Color(0xff151515);
  static Color textLightLight = const Color(0xff524B6B);
  static Color textHintLight = Colors.grey;

  /// dark theme
  static Color backgroundColorDark = Colors.black38;
  static Color textColorDark = Colors.white70;
  static Color textLightDark = Colors.white60;
  static Color textHintDark = Colors.white38;

  static ThemeData light() {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      primaryColor: accessColor,
      scaffoldBackgroundColor: backgroundColorLight,
      appBarTheme: AppBarTheme(
        foregroundColor: textColorLight,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: textColorLight,
          fontFamily: 'assets/fonts/PlusJakartaSans-SemiBold.ttf',
          fontSize: 16,
        ),
      ),
      hintColor: textHintLight,
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: textColorLight,
          fontFamily: 'assets/fonts/PlusJakartaSans-Bold.ttf',
          fontSize: 30,
          letterSpacing: 0.7,
        ),
        titleMedium: TextStyle(
          color: textColorLight,
          fontFamily: 'assets/fonts/PlusJakartaSans-SemiBold.ttf',
          fontSize: 30,
          letterSpacing: 0.7,
        ),
        titleSmall: TextStyle(
          color: textColorLight,
          fontFamily: 'assets/fonts/PlusJakartaSans-SemiBold.ttf',
          fontSize: 22,
          letterSpacing: 0.7,
        ),
        labelLarge: TextStyle(
          color: textColorLight,
          fontFamily: 'assets/fonts/PlusJakartaSans-SemiBold.ttf',
          fontSize: 18,
          letterSpacing: 0.7,
        ),
        labelMedium: TextStyle(
          color: textColorLight,
          fontFamily: 'assets/fonts/PlusJakartaSans-SemiBold.ttf',
          fontSize: 16,
          letterSpacing: 0.7,
        ),
        labelSmall: TextStyle(
          color: textColorLight,
          fontFamily: 'assets/fonts/PlusJakartaSans-Medium.ttf',
          fontSize: 14,
          letterSpacing: 0.7,
        ),
        bodyLarge: TextStyle(
          color: textColorLight,
          fontFamily: 'assets/fonts/PlusJakartaSans-Regular.ttf',
          fontSize: 12,
          letterSpacing: 0.7,
        ),
        bodyMedium: TextStyle(
          color: textColorLight,
          fontFamily: 'assets/fonts/PlusJakartaSans-Regular.ttf',
          fontSize: 10,
          letterSpacing: 0.7,
        ),
        headlineMedium: TextStyle(
          color: textColorLight,
          fontFamily: 'assets/fonts/PlusJakartaSans-ExtraBold.ttf',
          fontSize: 20,
        ),
        headlineSmall: TextStyle(
          color: textColorLight,
          fontFamily: 'InterLight',
          fontSize: 14,
        ),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.dark,
      primaryColor: accessColor,
      scaffoldBackgroundColor: backgroundColorDark,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: textColorDark,
        shadowColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: textColorDark,
          fontFamily: 'assets/fonts/PlusJakartaSans-SemiBold.ttf',
          fontSize: 16,
        ),
      ),
      hintColor: textHintLight,
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: textColorDark,
          fontFamily: 'assets/fonts/PlusJakartaSans-Bold.ttf',
          fontSize: 30,
        ),
        titleMedium: TextStyle(
          color: textColorDark,
          fontFamily: 'assets/fonts/PlusJakartaSans-Bold.ttf',
          fontSize: 30,
        ),
        titleSmall: TextStyle(
          color: textColorDark,
          fontFamily: 'assets/fonts/PlusJakartaSans-Bold.ttf',
          fontSize: 22,
        ),
        labelLarge: TextStyle(
          color: textColorDark,
          fontFamily: 'assets/fonts/PlusJakartaSans-Bold.ttf',
          fontSize: 18,
        ),
        labelMedium: TextStyle(
          color: textColorDark,
          fontFamily: 'assets/fonts/PlusJakartaSans-Bold.ttf',
          fontSize: 16,
        ),
        labelSmall: TextStyle(
          color: textColorDark,
          fontFamily: 'assets/fonts/PlusJakartaSans-SemiBold.ttf',
          fontSize: 14,
        ),
        bodyLarge: TextStyle(
          color: textColorDark,
          fontFamily: 'assets/fonts/PlusJakartaSans-Regular.ttf',
          fontSize: 12,
        ),
        bodyMedium: TextStyle(
          color: textColorDark,
          fontFamily: 'assets/fonts/PlusJakartaSans-Regular.ttf',
          fontSize: 10,
        ),
        headlineMedium: TextStyle(
          color: textColorDark,
          fontFamily: 'assets/fonts/PlusJakartaSans-Bold.ttf',
          fontSize: 20,
        ),
        headlineSmall: TextStyle(
          color: textColorDark,
          fontFamily: 'InterLight',
          fontSize: 14,
        ),
      ),
    );
  }
}

/// Welcome Back - titleLarge
// Font Plus Jakarta Sans
// Weight 700
// Size 30px

/// Welcome Back - headlineMedium
// Font Plus Jakarta Sans
// Weight 700
// Size 20px

/// Price - titleMedium
// Font Plus Jakarta Sans
// Weight 600
// Size 30px

/// On Boarding - titleSmall
// Font Plus Jakarta Sans
// Weight 600
// Size 22px

/// Font Plus Jakarta Sans - labelLarge
// Weight 600
// Size 18px

/// Font Plus Jakarta Sans - labelMedium
// Weight 600
// Size 16px

/// Font Plus Jakarta Sans - labelSmall
// Weight 500
// Size 14px

/// Font Plus Jakarta Sans - bodyLarge
// Weight 400
// Size 12px

/// Font Plus Jakarta Sans - bodyMedium
// Weight 400
// Size 10px

/// Font InterLight - headlineSmall
// Weight 300
// Size 14px


