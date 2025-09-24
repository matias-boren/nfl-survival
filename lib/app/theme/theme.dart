import 'package:flutter/material.dart';
import 'extensions.dart';

ThemeData buildAppTheme() {
  final base = ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo);
  return base.copyWith(
    appBarTheme: const AppBarTheme(centerTitle: true),
    extensions: const [AppSpacings()],
  );
}

