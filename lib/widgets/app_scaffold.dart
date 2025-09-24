import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final uri = GoRouter.of(context).routeInformationProvider.value.uri;
    final location = uri.toString();
    return Scaffold(
      appBar: appBar,
      body: child,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indexForLocation(location),
        onDestinationSelected: (i) => _onTap(i, context),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.group_outlined), selectedIcon: Icon(Icons.group), label: 'Leagues'),
          NavigationDestination(icon: Icon(Icons.newspaper_outlined), selectedIcon: Icon(Icons.newspaper), label: 'News'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

int _indexForLocation(String loc) {
  if (loc.startsWith('/leagues')) return 1;
  if (loc.startsWith('/news')) return 2;
  if (loc.startsWith('/settings')) return 3;
  return 0;
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
      context.go('/news');
      break;
    case 3:
      context.go('/settings');
      break;
  }
}
