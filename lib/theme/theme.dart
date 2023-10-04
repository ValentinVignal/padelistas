import 'package:flutter/material.dart';

ThemeData buildTheme(Brightness brightness) {
  final ColorScheme colorScheme;
  switch (brightness) {
    case Brightness.dark:
      colorScheme = ColorScheme.fromSeed(
        seedColor: const Color(0xFF6BC9A2),
        secondary: const Color(0xFF57767B),
        brightness: Brightness.dark,
      );
      break;
    case Brightness.light:
    default:
      colorScheme = ColorScheme.fromSeed(
        seedColor: const Color(0xFF6BC9A2),
        secondary: const Color(0xFF57767B),
        background: const Color(0xFFF8F8F0),
        brightness: Brightness.light,
      );
      break;
  }
  return ThemeData.from(
    colorScheme: colorScheme,
    useMaterial3: true,
  ).copyWith(
    bottomSheetTheme: const BottomSheetThemeData(
      showDragHandle: true,
    ),
  );
}
