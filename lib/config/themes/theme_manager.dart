import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

import 'color_scheme.dart';

class ThemeManager {
  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: AssetsManager.primaryFontFamily,
      scaffoldBackgroundColor: const Color(0xFFF1F0F4),
      colorScheme: lightColorScheme,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF1F0F4),
        scrolledUnderElevation: 0,
        elevation: 0,
        titleSpacing: 10,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: ColorsManager.textColorPrimary,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontFamily: AssetsManager.secondaryFontFamily,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontFamily: AssetsManager.secondaryFontFamily,
          fontWeight: FontWeight.w400,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontFamily: AssetsManager.secondaryFontFamily,
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: ColorsManager.lightPrimaryColor,
        ),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      ),
      iconTheme: const IconThemeData(color: Colors.black26, size: 24.0),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black.withValues(alpha: 0.8),
        selectedItemColor: ColorsManager.lightPrimaryColor,
        unselectedItemColor: Colors.white.withValues(alpha: 0.6),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFF1A1C1E),
      fontFamily: AssetsManager.primaryFontFamily,
      colorScheme: darkColorScheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1A1C1E),
        scrolledUnderElevation: 0,
        elevation: 0,
        titleSpacing: 10,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: ColorsManager.textColorPrimary,
        ),
      ),
      useMaterial3: true,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontFamily: AssetsManager.secondaryFontFamily,
          fontWeight: FontWeight.w400,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontFamily: AssetsManager.secondaryFontFamily,
          fontWeight: FontWeight.w400,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontFamily: AssetsManager.secondaryFontFamily,
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: ColorsManager.darkPrimaryColor,
        ),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      ),
      iconTheme: const IconThemeData(color: Colors.white, size: 24.0),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black.withValues(alpha: 0.8),
        selectedItemColor: ColorsManager.darkPrimaryColor,
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
