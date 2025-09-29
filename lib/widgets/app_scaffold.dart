import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nfl_survival/app/providers.dart';

class AppScaffold extends ConsumerWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final FloatingActionButton? floatingActionButton;

  const AppScaffold({
    super.key,
    required this.child,
    this.appBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uri = GoRouter.of(context).routeInformationProvider.value.uri;
    final location = uri.toString();
    final currentUser = ref.watch(currentUserProvider);
    
    // Hide navigation bar if user is not authenticated or on sign-in screen
    final shouldShowNavigation = currentUser != null && 
                                !location.contains('/signin') && 
                                !location.contains('/sign-in') &&
                                !location.contains('/loading');
    
    return Scaffold(
      appBar: appBar,
      body: child,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: shouldShowNavigation ? NavigationBar(
        selectedIndex: _indexForLocation(location),
        onDestinationSelected: (i) => _onTap(i, context),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.group_outlined), selectedIcon: Icon(Icons.group), label: 'Leagues'),
          NavigationDestination(icon: Icon(Icons.sports_football_outlined), selectedIcon: Icon(Icons.sports_football), label: 'Picks'),
          NavigationDestination(icon: Icon(Icons.newspaper_outlined), selectedIcon: Icon(Icons.newspaper), label: 'News'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ) : null,
    );
  }

  int _indexForLocation(String location) {
    if (location.startsWith('/leagues') || location.contains('/league/')) return 1;
    if (location.startsWith('/select-league') || location.startsWith('/make-pick')) return 2;
    if (location.startsWith('/news')) return 3;
    if (location.startsWith('/settings')) return 4;
    return 0; // Home
  }

  void _onTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/leagues');
        break;
      case 2:
        context.go('/select-league');
        break;
      case 3:
        context.go('/news');
        break;
      case 4:
        context.go('/settings');
        break;
    }
  }
}
