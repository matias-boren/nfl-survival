import 'package:flutter/material.dart';

/// Design tokens for the NFL Survival Pool app
/// Maps to Flutter ThemeExtensions for easy access throughout the app
class DesignTokens {
  // Colors
  static const Map<String, Color> lightColors = {
    'primary': Color(0xFF2563EB),
    'primaryContainer': Color(0xFFDBEAFE),
    'secondary': Color(0xFF7C3AED),
    'secondaryContainer': Color(0xFFEDE9FE),
    'tertiary': Color(0xFF059669),
    'tertiaryContainer': Color(0xFFD1FAE5),
    'error': Color(0xFFDC2626),
    'errorContainer': Color(0xFFFEE2E2),
    'warning': Color(0xFFD97706),
    'warningContainer': Color(0xFFFEF3C7),
    'success': Color(0xFF059669),
    'successContainer': Color(0xFFD1FAE5),
    'surface': Color(0xFFFFFFFF),
    'surfaceVariant': Color(0xFFF8FAFC),
    'background': Color(0xFFFFFFFF),
    'onPrimary': Color(0xFFFFFFFF),
    'onSecondary': Color(0xFFFFFFFF),
    'onTertiary': Color(0xFFFFFFFF),
    'onError': Color(0xFFFFFFFF),
    'onSurface': Color(0xFF1F2937),
    'onBackground': Color(0xFF1F2937),
    'outline': Color(0xFFE5E7EB),
    'outlineVariant': Color(0xFFF3F4F6),
    'shadow': Color(0xFF000000),
    'scrim': Color(0xFF000000),
    'inverseSurface': Color(0xFF374151),
    'inverseOnSurface': Color(0xFFFFFFFF),
    'inversePrimary': Color(0xFF93C5FD),
    'premium': Color(0xFF059669),
    'premiumContainer': Color(0xFFD1FAE5),
    'adBg': Color(0xFFF9FAFB),
    'adText': Color(0xFF6B7280),
    'locked': Color(0xFF9CA3AF),
    'lockedContainer': Color(0xFFF3F4F6),
  };

  static const Map<String, Color> darkColors = {
    'primary': Color(0xFF60A5FA),
    'primaryContainer': Color(0xFF1E3A8A),
    'secondary': Color(0xFFA78BFA),
    'secondaryContainer': Color(0xFF5B21B6),
    'tertiary': Color(0xFF34D399),
    'tertiaryContainer': Color(0xFF047857),
    'error': Color(0xFFF87171),
    'errorContainer': Color(0xFF7F1D1D),
    'warning': Color(0xFFFBBF24),
    'warningContainer': Color(0xFF92400E),
    'success': Color(0xFF34D399),
    'successContainer': Color(0xFF047857),
    'surface': Color(0xFF111827),
    'surfaceVariant': Color(0xFF1F2937),
    'background': Color(0xFF0F172A),
    'onPrimary': Color(0xFF000000),
    'onSecondary': Color(0xFF000000),
    'onTertiary': Color(0xFF000000),
    'onError': Color(0xFF000000),
    'onSurface': Color(0xFFF9FAFB),
    'onBackground': Color(0xFFF9FAFB),
    'outline': Color(0xFF374151),
    'outlineVariant': Color(0xFF4B5563),
    'shadow': Color(0xFF000000),
    'scrim': Color(0xFF000000),
    'inverseSurface': Color(0xFFE5E7EB),
    'inverseOnSurface': Color(0xFF1F2937),
    'inversePrimary': Color(0xFF1E40AF),
    'premium': Color(0xFF34D399),
    'premiumContainer': Color(0xFF047857),
    'adBg': Color(0xFF1F2937),
    'adText': Color(0xFF9CA3AF),
    'locked': Color(0xFF6B7280),
    'lockedContainer': Color(0xFF374151),
  };

  // Dark Grey theme colors (premium only)
  static const Map<String, Color> darkGreyColors = {
    'primary': Color(0xFF8B5CF6),
    'primaryContainer': Color(0xFF4C1D95),
    'secondary': Color(0xFFA78BFA),
    'secondaryContainer': Color(0xFF5B21B6),
    'tertiary': Color(0xFF34D399),
    'tertiaryContainer': Color(0xFF047857),
    'error': Color(0xFFF87171),
    'errorContainer': Color(0xFF7F1D1D),
    'warning': Color(0xFFFBBF24),
    'warningContainer': Color(0xFF92400E),
    'success': Color(0xFF34D399),
    'successContainer': Color(0xFF047857),
    'surface': Color(0xFF2D3748),
    'surfaceVariant': Color(0xFF4A5568),
    'background': Color(0xFF1A202C),
    'onPrimary': Color(0xFFFFFFFF),
    'onSecondary': Color(0xFFFFFFFF),
    'onTertiary': Color(0xFFFFFFFF),
    'onError': Color(0xFFFFFFFF),
    'onSurface': Color(0xFFE2E8F0),
    'onBackground': Color(0xFFE2E8F0),
    'outline': Color(0xFF4A5568),
    'outlineVariant': Color(0xFF718096),
    'shadow': Color(0xFF000000),
    'scrim': Color(0xFF000000),
    'inverseSurface': Color(0xFFE2E8F0),
    'inverseOnSurface': Color(0xFF2D3748),
    'inversePrimary': Color(0xFF4C1D95),
    'premium': Color(0xFF34D399),
    'premiumContainer': Color(0xFF047857),
    'adBg': Color(0xFF4A5568),
    'adText': Color(0xFFA0AEC0),
    'locked': Color(0xFF718096),
    'lockedContainer': Color(0xFF4A5568),
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
