import 'package:flutter/material.dart';
import '../../app/theme/theme_extensions.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionText;
  final VoidCallback? onAction;
  final EmptyStateSize size;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionText,
    this.onAction,
    this.size = EmptyStateSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appSizes = theme.extension<AppSizes>()!;
    
    final iconSize = _getIconSize(appSizes);
    final spacing = _getSpacing(appSizes);
    
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: spacing.md),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spacing.sm),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onAction != null) ...[
              SizedBox(height: spacing.lg),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
                child: Text(actionText!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  double _getIconSize(AppSizes sizes) {
    switch (size) {
      case EmptyStateSize.small:
        return sizes.iconXl;
      case EmptyStateSize.medium:
        return sizes.iconXl * 1.5;
      case EmptyStateSize.large:
        return sizes.iconXl * 2;
    }
  }

  AppSpacings _getSpacing(AppSizes sizes) {
    return const AppSpacings();
  }
}

enum EmptyStateSize {
  small,
  medium,
  large,
}

// Predefined empty states for common scenarios
class EmptyStates {
  static Widget noLeagues({
    required VoidCallback? onAction,
    EmptyStateSize size = EmptyStateSize.medium,
  }) {
    return EmptyState(
      icon: Icons.group_add,
      title: 'Join your first league',
      subtitle: 'Browse public leagues or create your own',
      actionText: 'Browse Leagues',
      onAction: onAction,
      size: size,
    );
  }

  static Widget noPicks({
    required VoidCallback? onAction,
    EmptyStateSize size = EmptyStateSize.medium,
  }) {
    return EmptyState(
      icon: Icons.sports_football,
      title: 'No picks this week',
      subtitle: 'Make your pick before the deadline',
      actionText: 'Make Pick',
      onAction: onAction,
      size: size,
    );
  }

  static Widget noNews({
    required VoidCallback? onAction,
    EmptyStateSize size = EmptyStateSize.medium,
  }) {
    return EmptyState(
      icon: Icons.article,
      title: 'No articles available',
      subtitle: 'Check back later for updates',
      actionText: 'Refresh',
      onAction: onAction,
      size: size,
    );
  }

  static Widget noInvitations({
    required VoidCallback? onAction,
    EmptyStateSize size = EmptyStateSize.medium,
  }) {
    return EmptyState(
      icon: Icons.mail,
      title: 'No pending invitations',
      subtitle: 'Ask a friend to send you a league invite code',
      actionText: 'Join with Code',
      onAction: onAction,
      size: size,
    );
  }
}
