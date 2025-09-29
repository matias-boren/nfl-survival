import 'package:flutter/material.dart';
import '../../app/theme/theme_extensions.dart';

class StatusPill extends StatelessWidget {
  final String status;
  final StatusPillVariant variant;
  final StatusPillSize size;
  final IconData? icon;

  const StatusPill({
    super.key,
    required this.status,
    this.variant = StatusPillVariant.primary,
    this.size = StatusPillSize.medium,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appSizes = theme.extension<AppSizes>()!;

    final pillHeight = _getPillHeight(appSizes);
    final textStyle = _getTextStyle(theme);
    final colors = _getColors(theme);

    return Container(
      height: pillHeight,
      padding: EdgeInsets.symmetric(
        horizontal: pillHeight * 0.4,
        vertical: pillHeight * 0.1,
      ),
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        borderRadius: BorderRadius.circular(pillHeight / 2),
        border: colors.borderColor != null
            ? Border.all(color: colors.borderColor!, width: 1)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: pillHeight * 0.6, color: colors.textColor),
            SizedBox(width: pillHeight * 0.2),
          ],
          Text(
            status,
            style: textStyle.copyWith(
              color: colors.textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  double _getPillHeight(AppSizes sizes) {
    switch (size) {
      case StatusPillSize.small:
        return sizes.iconMd;
      case StatusPillSize.medium:
        return sizes.iconLg;
      case StatusPillSize.large:
        return sizes.iconXl;
    }
  }

  TextStyle _getTextStyle(ThemeData theme) {
    switch (size) {
      case StatusPillSize.small:
        return theme.textTheme.labelSmall!;
      case StatusPillSize.medium:
        return theme.textTheme.labelMedium!;
      case StatusPillSize.large:
        return theme.textTheme.labelLarge!;
    }
  }

  _PillColors _getColors(ThemeData theme) {
    final appColors = theme.extension<AppColors>()!;

    switch (variant) {
      case StatusPillVariant.primary:
        return _PillColors(
          backgroundColor:
              appColors.primaryContainer ?? theme.colorScheme.primaryContainer,
          textColor: appColors.onPrimary ?? theme.colorScheme.onPrimary,
        );
      case StatusPillVariant.secondary:
        return _PillColors(
          backgroundColor:
              appColors.secondaryContainer ??
              theme.colorScheme.secondaryContainer,
          textColor: appColors.onSecondary ?? theme.colorScheme.onSecondary,
        );
      case StatusPillVariant.success:
        return _PillColors(
          backgroundColor:
              appColors.successContainer ?? theme.colorScheme.tertiaryContainer,
          textColor: appColors.onTertiary ?? theme.colorScheme.onTertiary,
        );
      case StatusPillVariant.warning:
        return _PillColors(
          backgroundColor:
              appColors.warningContainer ?? theme.colorScheme.errorContainer,
          textColor: appColors.onError ?? theme.colorScheme.onError,
        );
      case StatusPillVariant.error:
        return _PillColors(
          backgroundColor:
              appColors.errorContainer ?? theme.colorScheme.errorContainer,
          textColor: appColors.onError ?? theme.colorScheme.onError,
        );
      case StatusPillVariant.premium:
        return _PillColors(
          backgroundColor:
              appColors.premiumContainer ?? theme.colorScheme.primaryContainer,
          textColor: appColors.premium ?? theme.colorScheme.primary,
        );
      case StatusPillVariant.locked:
        return _PillColors(
          backgroundColor:
              appColors.lockedContainer ?? theme.colorScheme.surfaceVariant,
          textColor: appColors.locked ?? theme.colorScheme.onSurfaceVariant,
        );
      case StatusPillVariant.outline:
        return _PillColors(
          backgroundColor: Colors.transparent,
          textColor: appColors.primary ?? theme.colorScheme.primary,
          borderColor: appColors.primary ?? theme.colorScheme.primary,
        );
    }
  }
}

class _PillColors {
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  _PillColors({
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
  });
}

enum StatusPillVariant {
  primary,
  secondary,
  success,
  warning,
  error,
  premium,
  locked,
  outline,
}

enum StatusPillSize { small, medium, large }
