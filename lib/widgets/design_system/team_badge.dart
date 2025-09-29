import 'package:flutter/material.dart';
import '../../app/theme/theme_extensions.dart';

class TeamBadge extends StatelessWidget {
  final String team;
  final TeamBadgeSize size;
  final bool showName;
  final bool showLogo;
  final VoidCallback? onTap;

  const TeamBadge({
    super.key,
    required this.team,
    this.size = TeamBadgeSize.medium,
    this.showName = true,
    this.showLogo = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appSizes = theme.extension<AppSizes>()!;
    
    final badgeSize = _getBadgeSize(appSizes);
    final textStyle = _getTextStyle(theme);
    
    Widget content = Container(
      height: badgeSize,
      padding: EdgeInsets.symmetric(
        horizontal: badgeSize * 0.3,
        vertical: badgeSize * 0.1,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(badgeSize / 2),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLogo) ...[
            Icon(
              Icons.sports_football,
              size: badgeSize * 0.5,
              color: theme.colorScheme.primary,
            ),
            SizedBox(width: badgeSize * 0.2),
          ],
          if (showName)
            Text(
              team,
              style: textStyle.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );

    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(badgeSize / 2),
        child: content,
      );
    }

    return content;
  }

  double _getBadgeSize(AppSizes sizes) {
    switch (size) {
      case TeamBadgeSize.small:
        return sizes.avatarSm;
      case TeamBadgeSize.medium:
        return sizes.avatarMd;
      case TeamBadgeSize.large:
        return sizes.avatarLg;
    }
  }

  TextStyle _getTextStyle(ThemeData theme) {
    switch (size) {
      case TeamBadgeSize.small:
        return theme.textTheme.labelSmall!;
      case TeamBadgeSize.medium:
        return theme.textTheme.bodyMedium!;
      case TeamBadgeSize.large:
        return theme.textTheme.bodyLarge!;
    }
  }
}

enum TeamBadgeSize {
  small,
  medium,
  large,
}
