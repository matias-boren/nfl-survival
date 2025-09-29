import 'package:flutter/material.dart';
import 'theme_extensions.dart';
import 'design_tokens.dart';

ThemeData buildAppTheme() {
  final base = ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo);

  // Light theme colors
  final lightColors = AppColors(
    primary: DesignTokens.lightColors['primary'],
    primaryContainer: DesignTokens.lightColors['primaryContainer'],
    secondary: DesignTokens.lightColors['secondary'],
    secondaryContainer: DesignTokens.lightColors['secondaryContainer'],
    tertiary: DesignTokens.lightColors['tertiary'],
    tertiaryContainer: DesignTokens.lightColors['tertiaryContainer'],
    error: DesignTokens.lightColors['error'],
    errorContainer: DesignTokens.lightColors['errorContainer'],
    warning: DesignTokens.lightColors['warning'],
    warningContainer: DesignTokens.lightColors['warningContainer'],
    success: DesignTokens.lightColors['success'],
    successContainer: DesignTokens.lightColors['successContainer'],
    surface: DesignTokens.lightColors['surface'],
    surfaceVariant: DesignTokens.lightColors['surfaceVariant'],
    background: DesignTokens.lightColors['background'],
    onPrimary: DesignTokens.lightColors['onPrimary'],
    onSecondary: DesignTokens.lightColors['onSecondary'],
    onTertiary: DesignTokens.lightColors['onTertiary'],
    onError: DesignTokens.lightColors['onError'],
    onSurface: DesignTokens.lightColors['onSurface'],
    onBackground: DesignTokens.lightColors['onBackground'],
    outline: DesignTokens.lightColors['outline'],
    outlineVariant: DesignTokens.lightColors['outlineVariant'],
    shadow: DesignTokens.lightColors['shadow'],
    scrim: DesignTokens.lightColors['scrim'],
    inverseSurface: DesignTokens.lightColors['inverseSurface'],
    inverseOnSurface: DesignTokens.lightColors['inverseOnSurface'],
    inversePrimary: DesignTokens.lightColors['inversePrimary'],
    premium: DesignTokens.lightColors['premium'],
    premiumContainer: DesignTokens.lightColors['premiumContainer'],
    adBg: DesignTokens.lightColors['adBg'],
    adText: DesignTokens.lightColors['adText'],
    locked: DesignTokens.lightColors['locked'],
    lockedContainer: DesignTokens.lightColors['lockedContainer'],
  );

  return base.copyWith(
    appBarTheme: const AppBarTheme(centerTitle: true),
    extensions: [lightColors, const AppSpacings(), const AppSizes()],
  );
}

ThemeData buildAppDarkTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.indigo,
    brightness: Brightness.dark,
  );

  // Dark theme colors
  final darkColors = AppColors(
    primary: DesignTokens.darkColors['primary'],
    primaryContainer: DesignTokens.darkColors['primaryContainer'],
    secondary: DesignTokens.darkColors['secondary'],
    secondaryContainer: DesignTokens.darkColors['secondaryContainer'],
    tertiary: DesignTokens.darkColors['tertiary'],
    tertiaryContainer: DesignTokens.darkColors['tertiaryContainer'],
    error: DesignTokens.darkColors['error'],
    errorContainer: DesignTokens.darkColors['errorContainer'],
    warning: DesignTokens.darkColors['warning'],
    warningContainer: DesignTokens.darkColors['warningContainer'],
    success: DesignTokens.darkColors['success'],
    successContainer: DesignTokens.darkColors['successContainer'],
    surface: DesignTokens.darkColors['surface'],
    surfaceVariant: DesignTokens.darkColors['surfaceVariant'],
    background: DesignTokens.darkColors['background'],
    onPrimary: DesignTokens.darkColors['onPrimary'],
    onSecondary: DesignTokens.darkColors['onSecondary'],
    onTertiary: DesignTokens.darkColors['onTertiary'],
    onError: DesignTokens.darkColors['onError'],
    onSurface: DesignTokens.darkColors['onSurface'],
    onBackground: DesignTokens.darkColors['onBackground'],
    outline: DesignTokens.darkColors['outline'],
    outlineVariant: DesignTokens.darkColors['outlineVariant'],
    shadow: DesignTokens.darkColors['shadow'],
    scrim: DesignTokens.darkColors['scrim'],
    inverseSurface: DesignTokens.darkColors['inverseSurface'],
    inverseOnSurface: DesignTokens.darkColors['inverseOnSurface'],
    inversePrimary: DesignTokens.darkColors['inversePrimary'],
    premium: DesignTokens.darkColors['premium'],
    premiumContainer: DesignTokens.darkColors['premiumContainer'],
    adBg: DesignTokens.darkColors['adBg'],
    adText: DesignTokens.darkColors['adText'],
    locked: DesignTokens.darkColors['locked'],
    lockedContainer: DesignTokens.darkColors['lockedContainer'],
  );

  return base.copyWith(
    appBarTheme: const AppBarTheme(centerTitle: true),
    extensions: [darkColors, const AppSpacings(), const AppSizes()],
  );
}

ThemeData buildAppDarkGreyTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.purple,
    brightness: Brightness.dark,
  );

  // Dark Grey theme colors
  final darkGreyColors = AppColors(
    primary: DesignTokens.darkGreyColors['primary'],
    primaryContainer: DesignTokens.darkGreyColors['primaryContainer'],
    secondary: DesignTokens.darkGreyColors['secondary'],
    secondaryContainer: DesignTokens.darkGreyColors['secondaryContainer'],
    tertiary: DesignTokens.darkGreyColors['tertiary'],
    tertiaryContainer: DesignTokens.darkGreyColors['tertiaryContainer'],
    error: DesignTokens.darkGreyColors['error'],
    errorContainer: DesignTokens.darkGreyColors['errorContainer'],
    warning: DesignTokens.darkGreyColors['warning'],
    warningContainer: DesignTokens.darkGreyColors['warningContainer'],
    success: DesignTokens.darkGreyColors['success'],
    successContainer: DesignTokens.darkGreyColors['successContainer'],
    surface: DesignTokens.darkGreyColors['surface'],
    surfaceVariant: DesignTokens.darkGreyColors['surfaceVariant'],
    background: DesignTokens.darkGreyColors['background'],
    onPrimary: DesignTokens.darkGreyColors['onPrimary'],
    onSecondary: DesignTokens.darkGreyColors['onSecondary'],
    onTertiary: DesignTokens.darkGreyColors['onTertiary'],
    onError: DesignTokens.darkGreyColors['onError'],
    onSurface: DesignTokens.darkGreyColors['onSurface'],
    onBackground: DesignTokens.darkGreyColors['onBackground'],
    outline: DesignTokens.darkGreyColors['outline'],
    outlineVariant: DesignTokens.darkGreyColors['outlineVariant'],
    shadow: DesignTokens.darkGreyColors['shadow'],
    scrim: DesignTokens.darkGreyColors['scrim'],
    inverseSurface: DesignTokens.darkGreyColors['inverseSurface'],
    inverseOnSurface: DesignTokens.darkGreyColors['inverseOnSurface'],
    inversePrimary: DesignTokens.darkGreyColors['inversePrimary'],
    premium: DesignTokens.darkGreyColors['premium'],
    premiumContainer: DesignTokens.darkGreyColors['premiumContainer'],
    adBg: DesignTokens.darkGreyColors['adBg'],
    adText: DesignTokens.darkGreyColors['adText'],
    locked: DesignTokens.darkGreyColors['locked'],
    lockedContainer: DesignTokens.darkGreyColors['lockedContainer'],
  );

  return base.copyWith(
    appBarTheme: const AppBarTheme(centerTitle: true),
    extensions: [darkGreyColors, const AppSpacings(), const AppSizes()],
  );
}
