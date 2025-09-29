import 'package:flutter/material.dart';

/// Design tokens for the NFL Survival Pool app
/// Universal Dark Grey Theme with specified colors
class DesignTokens {
  // Colors - Universal Dark Grey Theme
  static const Map<String, Color> colors = {
    'primary': Color(0xFF76ABAE), // Teal accent
    'primaryContainer': Color(0xFF31363F), // Dark grey container
    'secondary': Color(0xFF76ABAE), // Same as primary
    'secondaryContainer': Color(0xFF31363F), // Dark grey container
    'tertiary': Color(0xFF76ABAE), // Same as primary
    'tertiaryContainer': Color(0xFF31363F), // Dark grey container
    'error': Color(0xFFFF6B6B), // Red for errors
    'errorContainer': Color(0xFF31363F), // Dark grey container
    'warning': Color(0xFFFFD93D), // Yellow for warnings
    'warningContainer': Color(0xFF31363F), // Dark grey container
    'success': Color(0xFF76ABAE), // Teal for success
    'successContainer': Color(0xFF31363F), // Dark grey container
    'surface': Color(0xFF222831), // Main dark background
    'surfaceVariant': Color(0xFF31363F), // Slightly lighter dark
    'background': Color(0xFF222831), // Main background
    'onPrimary': Color(0xFF222831), // Dark text on teal
    'onSecondary': Color(0xFF222831), // Dark text on teal
    'onTertiary': Color(0xFF222831), // Dark text on teal
    'onError': Color(0xFFEEEEEE), // Light text on error
    'onSurface': Color(0xFFEEEEEE), // Light text on dark
    'onBackground': Color(0xFFEEEEEE), // Light text on dark
    'outline': Color(0xFF31363F), // Dark grey outline
    'outlineVariant': Color(0xFF76ABAE), // Teal outline variant
    'shadow': Color(0xFF000000), // Black shadow
    'scrim': Color(0xFF000000), // Black scrim
    'inverseSurface': Color(0xFFEEEEEE), // Light inverse surface
    'inverseOnSurface': Color(0xFF222831), // Dark text on light
    'inversePrimary': Color(0xFF76ABAE), // Teal inverse primary
    'premium': Color(0xFF76ABAE), // Teal for premium
    'premiumContainer': Color(0xFF31363F), // Dark grey container
    'adBg': Color(0xFF31363F), // Dark grey for ads
    'adText': Color(0xFFEEEEEE), // Light text for ads
    'locked': Color(0xFF76ABAE), // Teal for locked features
    'lockedContainer': Color(0xFF31363F), // Dark grey container
  };

  // Spacing
  static const Map<String, double> spacing = {
    'xs': 4.0,
    'sm': 8.0,
    'md': 16.0,
    'lg': 24.0,
    'xl': 32.0,
    'xxl': 48.0,
    'xxxl': 64.0,
  };

  // Radius
  static const Map<String, double> radius = {
    'xs': 4.0,
    'sm': 8.0,
    'md': 12.0,
    'lg': 16.0,
    'xl': 24.0,
    'full': 9999.0,
  };

  // Elevation
  static const Map<String, double> elevation = {
    'none': 0.0,
    'xs': 1.0,
    'sm': 3.0,
    'md': 6.0,
    'lg': 8.0,
    'xl': 12.0,
  };

  // Sizes
  static const Map<String, double> sizes = {
    'tapMin': 48.0,
    'iconSm': 16.0,
    'iconMd': 24.0,
    'iconLg': 32.0,
    'iconXl': 48.0,
    'avatarSm': 32.0,
    'avatarMd': 40.0,
    'avatarLg': 56.0,
    'bannerHeight': 50.0,
    'bannerHeightLg': 90.0,
  };

  // Animation durations
  static const Map<String, int> animation = {
    'durationFast': 150,
    'durationNormal': 250,
    'durationSlow': 350,
  };

  // States opacity
  static const Map<String, double> states = {
    'hover': 0.08,
    'focus': 0.12,
    'pressed': 0.12,
    'disabled': 0.38,
  };
}