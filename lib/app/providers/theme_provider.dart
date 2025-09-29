import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/theme.dart';

enum AppThemeMode { light, darkGrey, dark }

class ThemeNotifier extends StateNotifier<AppThemeMode> {
  ThemeNotifier() : super(AppThemeMode.light) {
    _loadTheme();
  }

  static const String _themeKey = 'app_theme_mode';

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt(_themeKey) ?? 0;
      state = AppThemeMode.values[themeIndex];
    } catch (e) {
      // Default to light theme if loading fails
      state = AppThemeMode.light;
    }
  }

  Future<void> setTheme(AppThemeMode theme) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, theme.index);
      // Force a state change to trigger rebuilds
      state = theme;
      print('Theme changed to: $theme');
    } catch (e) {
      print('Error setting theme: $e');
    }
  }

  ThemeData getCurrentTheme() {
    switch (state) {
      case AppThemeMode.light:
        return buildAppTheme();
      case AppThemeMode.darkGrey:
        return buildAppDarkGreyTheme();
      case AppThemeMode.dark:
        return buildAppDarkTheme();
    }
  }

  ThemeMode getMaterialThemeMode() {
    // We handle theme switching manually, so always use light as base
    // and override with our custom themes
    return ThemeMode.light;
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeMode>((ref) {
  return ThemeNotifier();
});

final currentThemeProvider = Provider<ThemeData>((ref) {
  final themeMode = ref.watch(themeProvider);
  print('Current theme provider called with mode: $themeMode');

  // Force rebuild by creating new ThemeData each time
  switch (themeMode) {
    case AppThemeMode.light:
      return buildAppTheme();
    case AppThemeMode.darkGrey:
      return buildAppDarkGreyTheme();
    case AppThemeMode.dark:
      return buildAppDarkTheme();
  }
});
