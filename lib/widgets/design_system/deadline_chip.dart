import 'package:flutter/material.dart';
import '../../app/theme/theme_extensions.dart';

class DeadlineChip extends StatelessWidget {
  final DateTime deadline;
  final DeadlineChipSize size;
  final VoidCallback? onTap;

  const DeadlineChip({
    super.key,
    required this.deadline,
    this.size = DeadlineChipSize.medium,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final timeUntilDeadline = deadline.difference(now);
    final status = _getDeadlineStatus(timeUntilDeadline);
    
    final theme = Theme.of(context);
    final appSizes = theme.extension<AppSizes>()!;
    
    final chipHeight = _getChipHeight(appSizes);
    final textStyle = _getTextStyle(theme);
    final colors = _getStatusColors(status, theme);
    final displayText = _getDisplayText(timeUntilDeadline, status);
    final icon = _getStatusIcon(status);
    
    Widget content = Container(
      height: chipHeight,
      padding: EdgeInsets.symmetric(
        horizontal: chipHeight * 0.4,
        vertical: chipHeight * 0.1,
      ),
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        borderRadius: BorderRadius.circular(chipHeight / 2),
        border: colors.borderColor != null 
          ? Border.all(color: colors.borderColor!, width: 1)
          : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: chipHeight * 0.6,
            color: colors.textColor,
          ),
          SizedBox(width: chipHeight * 0.2),
          Text(
            displayText,
            style: textStyle.copyWith(
              color: colors.textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(chipHeight / 2),
        child: content,
      );
    }

    return content;
  }

  DeadlineStatus _getDeadlineStatus(Duration timeUntil) {
    if (timeUntil.isNegative) {
      return DeadlineStatus.locked;
    } else if (timeUntil.inMinutes < 5) {
      return DeadlineStatus.critical;
    } else if (timeUntil.inMinutes < 30) {
      return DeadlineStatus.warning;
    } else if (timeUntil.inDays >= 1) {
      return DeadlineStatus.upcoming;
    } else {
      return DeadlineStatus.approaching;
    }
  }

  String _getDisplayText(Duration timeUntil, DeadlineStatus status) {
    if (status == DeadlineStatus.locked) {
      return 'Picks locked';
    }
    
    if (timeUntil.isNegative) {
      return 'Week complete';
    }
    
    final days = timeUntil.inDays;
    final hours = timeUntil.inHours % 24;
    final minutes = timeUntil.inMinutes % 60;
    
    if (days > 0) {
      return 'Picks lock in ${days}d ${hours}h';
    } else if (hours > 0) {
      return 'Picks lock in ${hours}h ${minutes}m';
    } else {
      return 'Picks lock in ${minutes}m';
    }
  }

  IconData _getStatusIcon(DeadlineStatus status) {
    switch (status) {
      case DeadlineStatus.upcoming:
        return Icons.access_time;
      case DeadlineStatus.approaching:
        return Icons.access_time;
      case DeadlineStatus.warning:
        return Icons.warning;
      case DeadlineStatus.critical:
        return Icons.warning_amber;
      case DeadlineStatus.locked:
        return Icons.lock;
    }
  }

  double _getChipHeight(AppSizes sizes) {
    switch (size) {
      case DeadlineChipSize.small:
        return sizes.iconMd;
      case DeadlineChipSize.medium:
        return sizes.iconLg;
      case DeadlineChipSize.large:
        return sizes.iconXl;
    }
  }

  TextStyle _getTextStyle(ThemeData theme) {
    switch (size) {
      case DeadlineChipSize.small:
        return theme.textTheme.labelSmall!;
      case DeadlineChipSize.medium:
        return theme.textTheme.labelMedium!;
      case DeadlineChipSize.large:
        return theme.textTheme.labelLarge!;
    }
  }

  _DeadlineColors _getStatusColors(DeadlineStatus status, ThemeData theme) {
    final appColors = theme.extension<AppColors>()!;
    
    switch (status) {
      case DeadlineStatus.upcoming:
        return _DeadlineColors(
          backgroundColor: appColors.successContainer ?? theme.colorScheme.tertiaryContainer,
          textColor: appColors.onTertiary ?? theme.colorScheme.onTertiary,
        );
      case DeadlineStatus.approaching:
        return _DeadlineColors(
          backgroundColor: appColors.primaryContainer ?? theme.colorScheme.primaryContainer,
          textColor: appColors.onPrimary ?? theme.colorScheme.onPrimary,
        );
      case DeadlineStatus.warning:
        return _DeadlineColors(
          backgroundColor: appColors.warningContainer ?? theme.colorScheme.errorContainer,
          textColor: appColors.onError ?? theme.colorScheme.onError,
        );
      case DeadlineStatus.critical:
        return _DeadlineColors(
          backgroundColor: appColors.error ?? theme.colorScheme.error,
          textColor: appColors.onError ?? theme.colorScheme.onError,
        );
      case DeadlineStatus.locked:
        return _DeadlineColors(
          backgroundColor: appColors.lockedContainer ?? theme.colorScheme.surfaceVariant,
          textColor: appColors.locked ?? theme.colorScheme.onSurfaceVariant,
        );
    }
  }
}

class _DeadlineColors {
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  _DeadlineColors({
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
  });
}

enum DeadlineStatus {
  upcoming,
  approaching,
  warning,
  critical,
  locked,
}

enum DeadlineChipSize {
  small,
  medium,
  large,
}
