import 'package:flutter/material.dart';
import 'dart:ui' show lerpDouble;

/// Extended theme extensions for the Pick1 app
@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color? primary;
  final Color? primaryContainer;
  final Color? secondary;
  final Color? secondaryContainer;
  final Color? tertiary;
  final Color? tertiaryContainer;
  final Color? error;
  final Color? errorContainer;
  final Color? warning;
  final Color? warningContainer;
  final Color? success;
  final Color? successContainer;
  final Color? surface;
  final Color? surfaceVariant;
  final Color? background;
  final Color? onPrimary;
  final Color? onSecondary;
  final Color? onTertiary;
  final Color? onError;
  final Color? onSurface;
  final Color? onBackground;
  final Color? outline;
  final Color? outlineVariant;
  final Color? shadow;
  final Color? scrim;
  final Color? inverseSurface;
  final Color? inverseOnSurface;
  final Color? inversePrimary;
  final Color? premium;
  final Color? premiumContainer;
  final Color? adBg;
  final Color? adText;
  final Color? locked;
  final Color? lockedContainer;

  const AppColors({
    this.primary,
    this.primaryContainer,
    this.secondary,
    this.secondaryContainer,
    this.tertiary,
    this.tertiaryContainer,
    this.error,
    this.errorContainer,
    this.warning,
    this.warningContainer,
    this.success,
    this.successContainer,
    this.surface,
    this.surfaceVariant,
    this.background,
    this.onPrimary,
    this.onSecondary,
    this.onTertiary,
    this.onError,
    this.onSurface,
    this.onBackground,
    this.outline,
    this.outlineVariant,
    this.shadow,
    this.scrim,
    this.inverseSurface,
    this.inverseOnSurface,
    this.inversePrimary,
    this.premium,
    this.premiumContainer,
    this.adBg,
    this.adText,
    this.locked,
    this.lockedContainer,
  });

  @override
  AppColors copyWith({
    Color? primary,
    Color? primaryContainer,
    Color? secondary,
    Color? secondaryContainer,
    Color? tertiary,
    Color? tertiaryContainer,
    Color? error,
    Color? errorContainer,
    Color? warning,
    Color? warningContainer,
    Color? success,
    Color? successContainer,
    Color? surface,
    Color? surfaceVariant,
    Color? background,
    Color? onPrimary,
    Color? onSecondary,
    Color? onTertiary,
    Color? onError,
    Color? onSurface,
    Color? onBackground,
    Color? outline,
    Color? outlineVariant,
    Color? shadow,
    Color? scrim,
    Color? inverseSurface,
    Color? inverseOnSurface,
    Color? inversePrimary,
    Color? premium,
    Color? premiumContainer,
    Color? adBg,
    Color? adText,
    Color? locked,
    Color? lockedContainer,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      secondary: secondary ?? this.secondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      tertiary: tertiary ?? this.tertiary,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      error: error ?? this.error,
      errorContainer: errorContainer ?? this.errorContainer,
      warning: warning ?? this.warning,
      warningContainer: warningContainer ?? this.warningContainer,
      success: success ?? this.success,
      successContainer: successContainer ?? this.successContainer,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      background: background ?? this.background,
      onPrimary: onPrimary ?? this.onPrimary,
      onSecondary: onSecondary ?? this.onSecondary,
      onTertiary: onTertiary ?? this.onTertiary,
      onError: onError ?? this.onError,
      onSurface: onSurface ?? this.onSurface,
      onBackground: onBackground ?? this.onBackground,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      shadow: shadow ?? this.shadow,
      scrim: scrim ?? this.scrim,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      inverseOnSurface: inverseOnSurface ?? this.inverseOnSurface,
      inversePrimary: inversePrimary ?? this.inversePrimary,
      premium: premium ?? this.premium,
      premiumContainer: premiumContainer ?? this.premiumContainer,
      adBg: adBg ?? this.adBg,
      adText: adText ?? this.adText,
      locked: locked ?? this.locked,
      lockedContainer: lockedContainer ?? this.lockedContainer,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t),
      primaryContainer: Color.lerp(primaryContainer, other.primaryContainer, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      secondaryContainer: Color.lerp(
        secondaryContainer,
        other.secondaryContainer,
        t,
      ),
      tertiary: Color.lerp(tertiary, other.tertiary, t),
      tertiaryContainer: Color.lerp(
        tertiaryContainer,
        other.tertiaryContainer,
        t,
      ),
      error: Color.lerp(error, other.error, t),
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t),
      warning: Color.lerp(warning, other.warning, t),
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t),
      success: Color.lerp(success, other.success, t),
      successContainer: Color.lerp(successContainer, other.successContainer, t),
      surface: Color.lerp(surface, other.surface, t),
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t),
      background: Color.lerp(background, other.background, t),
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t),
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t),
      onTertiary: Color.lerp(onTertiary, other.onTertiary, t),
      onError: Color.lerp(onError, other.onError, t),
      onSurface: Color.lerp(onSurface, other.onSurface, t),
      onBackground: Color.lerp(onBackground, other.onBackground, t),
      outline: Color.lerp(outline, other.outline, t),
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t),
      shadow: Color.lerp(shadow, other.shadow, t),
      scrim: Color.lerp(scrim, other.scrim, t),
      inverseSurface: Color.lerp(inverseSurface, other.inverseSurface, t),
      inverseOnSurface: Color.lerp(inverseOnSurface, other.inverseOnSurface, t),
      inversePrimary: Color.lerp(inversePrimary, other.inversePrimary, t),
      premium: Color.lerp(premium, other.premium, t),
      premiumContainer: Color.lerp(premiumContainer, other.premiumContainer, t),
      adBg: Color.lerp(adBg, other.adBg, t),
      adText: Color.lerp(adText, other.adText, t),
      locked: Color.lerp(locked, other.locked, t),
      lockedContainer: Color.lerp(lockedContainer, other.lockedContainer, t),
    );
  }
}

@immutable
class AppSpacings extends ThemeExtension<AppSpacings> {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double xxxl;

  const AppSpacings({
    this.xs = 4.0,
    this.sm = 8.0,
    this.md = 16.0,
    this.lg = 24.0,
    this.xl = 32.0,
    this.xxl = 48.0,
    this.xxxl = 64.0,
  });

  @override
  AppSpacings copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? xxxl,
  }) {
    return AppSpacings(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      xxxl: xxxl ?? this.xxxl,
    );
  }

  @override
  AppSpacings lerp(ThemeExtension<AppSpacings>? other, double t) {
    if (other is! AppSpacings) return this;
    return AppSpacings(
      xs: lerpDouble(xs, other.xs, t) ?? xs,
      sm: lerpDouble(sm, other.sm, t) ?? sm,
      md: lerpDouble(md, other.md, t) ?? md,
      lg: lerpDouble(lg, other.lg, t) ?? lg,
      xl: lerpDouble(xl, other.xl, t) ?? xl,
      xxl: lerpDouble(xxl, other.xxl, t) ?? xxl,
      xxxl: lerpDouble(xxxl, other.xxxl, t) ?? xxxl,
    );
  }
}

@immutable
class AppSizes extends ThemeExtension<AppSizes> {
  final double tapMin;
  final double iconSm;
  final double iconMd;
  final double iconLg;
  final double iconXl;
  final double avatarSm;
  final double avatarMd;
  final double avatarLg;
  final double bannerHeight;
  final double bannerHeightLg;

  const AppSizes({
    this.tapMin = 48.0,
    this.iconSm = 16.0,
    this.iconMd = 24.0,
    this.iconLg = 32.0,
    this.iconXl = 48.0,
    this.avatarSm = 32.0,
    this.avatarMd = 40.0,
    this.avatarLg = 56.0,
    this.bannerHeight = 50.0,
    this.bannerHeightLg = 90.0,
  });

  @override
  AppSizes copyWith({
    double? tapMin,
    double? iconSm,
    double? iconMd,
    double? iconLg,
    double? iconXl,
    double? avatarSm,
    double? avatarMd,
    double? avatarLg,
    double? bannerHeight,
    double? bannerHeightLg,
  }) {
    return AppSizes(
      tapMin: tapMin ?? this.tapMin,
      iconSm: iconSm ?? this.iconSm,
      iconMd: iconMd ?? this.iconMd,
      iconLg: iconLg ?? this.iconLg,
      iconXl: iconXl ?? this.iconXl,
      avatarSm: avatarSm ?? this.avatarSm,
      avatarMd: avatarMd ?? this.avatarMd,
      avatarLg: avatarLg ?? this.avatarLg,
      bannerHeight: bannerHeight ?? this.bannerHeight,
      bannerHeightLg: bannerHeightLg ?? this.bannerHeightLg,
    );
  }

  @override
  AppSizes lerp(ThemeExtension<AppSizes>? other, double t) {
    if (other is! AppSizes) return this;
    return AppSizes(
      tapMin: lerpDouble(tapMin, other.tapMin, t) ?? tapMin,
      iconSm: lerpDouble(iconSm, other.iconSm, t) ?? iconSm,
      iconMd: lerpDouble(iconMd, other.iconMd, t) ?? iconMd,
      iconLg: lerpDouble(iconLg, other.iconLg, t) ?? iconLg,
      iconXl: lerpDouble(iconXl, other.iconXl, t) ?? iconXl,
      avatarSm: lerpDouble(avatarSm, other.avatarSm, t) ?? avatarSm,
      avatarMd: lerpDouble(avatarMd, other.avatarMd, t) ?? avatarMd,
      avatarLg: lerpDouble(avatarLg, other.avatarLg, t) ?? avatarLg,
      bannerHeight:
          lerpDouble(bannerHeight, other.bannerHeight, t) ?? bannerHeight,
      bannerHeightLg:
          lerpDouble(bannerHeightLg, other.bannerHeightLg, t) ?? bannerHeightLg,
    );
  }
}
