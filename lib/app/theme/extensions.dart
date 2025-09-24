import 'package:flutter/material.dart';
import 'dart:ui' show lerpDouble;

@immutable
class AppSpacings extends ThemeExtension<AppSpacings> {
  final double sm;
  final double md;
  final double lg;
  const AppSpacings({this.sm = 8, this.md = 16, this.lg = 24});

  @override
  AppSpacings copyWith({double? sm, double? md, double? lg}) => AppSpacings(
        sm: sm ?? this.sm,
        md: md ?? this.md,
        lg: lg ?? this.lg,
      );

  @override
  AppSpacings lerp(ThemeExtension<AppSpacings>? other, double t) {
    if (other is! AppSpacings) return this;
    return AppSpacings(
      sm: lerpDouble(sm, other.sm, t) ?? sm,
      md: lerpDouble(md, other.md, t) ?? md,
      lg: lerpDouble(lg, other.lg, t) ?? lg,
    );
  }
}

