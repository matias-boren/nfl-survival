import 'package:flutter/material.dart';
import 'theme_extensions.dart';
import 'design_tokens.dart';

/// Builds the universal dark grey theme for the Pick1 app
ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: const Color(0xFF76ABAE), // Teal accent
  );

  // Dark grey theme colors
  final appColors = AppColors(
    primary: DesignTokens.colors['primary'],
    primaryContainer: DesignTokens.colors['primaryContainer'],
    secondary: DesignTokens.colors['secondary'],
    secondaryContainer: DesignTokens.colors['secondaryContainer'],
    tertiary: DesignTokens.colors['tertiary'],
    tertiaryContainer: DesignTokens.colors['tertiaryContainer'],
    error: DesignTokens.colors['error'],
    errorContainer: DesignTokens.colors['errorContainer'],
    warning: DesignTokens.colors['warning'],
    warningContainer: DesignTokens.colors['warningContainer'],
    success: DesignTokens.colors['success'],
    successContainer: DesignTokens.colors['successContainer'],
    surface: DesignTokens.colors['surface'],
    surfaceVariant: DesignTokens.colors['surfaceVariant'],
    background: DesignTokens.colors['background'],
    onPrimary: DesignTokens.colors['onPrimary'],
    onSecondary: DesignTokens.colors['onSecondary'],
    onTertiary: DesignTokens.colors['onTertiary'],
    onError: DesignTokens.colors['onError'],
    onSurface: DesignTokens.colors['onSurface'],
    onBackground: DesignTokens.colors['onBackground'],
    outline: DesignTokens.colors['outline'],
    outlineVariant: DesignTokens.colors['outlineVariant'],
    shadow: DesignTokens.colors['shadow'],
    scrim: DesignTokens.colors['scrim'],
    inverseSurface: DesignTokens.colors['inverseSurface'],
    inverseOnSurface: DesignTokens.colors['inverseOnSurface'],
    inversePrimary: DesignTokens.colors['inversePrimary'],
    premium: DesignTokens.colors['premium'],
    premiumContainer: DesignTokens.colors['premiumContainer'],
    adBg: DesignTokens.colors['adBg'],
    adText: DesignTokens.colors['adText'],
    locked: DesignTokens.colors['locked'],
    lockedContainer: DesignTokens.colors['lockedContainer'],
  );

  return base.copyWith(
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF76ABAE),
      onPrimary: Color(0xFF222831),
      secondary: Color(0xFF76ABAE),
      onSecondary: Color(0xFF222831),
      tertiary: Color(0xFF76ABAE),
      onTertiary: Color(0xFF222831),
      error: Color(0xFFFF6B6B),
      onError: Color(0xFFEEEEEE),
      surface: Color(0xFF222831),
      onSurface: Color(0xFFEEEEEE),
      background: Color(0xFF222831),
      onBackground: Color(0xFFEEEEEE),
      outline: Color(0xFF31363F),
      outlineVariant: Color(0xFF76ABAE),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Color(0xFF222831),
      foregroundColor: Color(0xFFEEEEEE),
      elevation: 0,
    ),
    scaffoldBackgroundColor: const Color(0xFF222831),
    cardTheme: CardThemeData(
      color: const Color(0xFF31363F),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF76ABAE),
        foregroundColor: const Color(0xFF222831),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF76ABAE),
        side: const BorderSide(color: Color(0xFF76ABAE)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFF76ABAE)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF31363F),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF31363F)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF31363F)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 2),
      ),
      labelStyle: const TextStyle(color: Color(0xFFEEEEEE)),
      hintStyle: const TextStyle(color: Color(0xFF76ABAE)),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Color(0xFFEEEEEE)),
      displayMedium: TextStyle(color: Color(0xFFEEEEEE)),
      displaySmall: TextStyle(color: Color(0xFFEEEEEE)),
      headlineLarge: TextStyle(color: Color(0xFFEEEEEE)),
      headlineMedium: TextStyle(color: Color(0xFFEEEEEE)),
      headlineSmall: TextStyle(color: Color(0xFFEEEEEE)),
      titleLarge: TextStyle(color: Color(0xFFEEEEEE)),
      titleMedium: TextStyle(color: Color(0xFFEEEEEE)),
      titleSmall: TextStyle(color: Color(0xFFEEEEEE)),
      bodyLarge: TextStyle(color: Color(0xFFEEEEEE)),
      bodyMedium: TextStyle(color: Color(0xFFEEEEEE)),
      bodySmall: TextStyle(color: Color(0xFF76ABAE)),
      labelLarge: TextStyle(color: Color(0xFFEEEEEE)),
      labelMedium: TextStyle(color: Color(0xFFEEEEEE)),
      labelSmall: TextStyle(color: Color(0xFF76ABAE)),
    ),
    extensions: [appColors, const AppSpacings(), const AppSizes()],
  );
}
