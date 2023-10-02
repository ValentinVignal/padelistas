import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padelistas/services/isar_provider.dart';

import '../theme/theme_provider.dart';

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({super.key});

  static const _values = [ThemeMode.light, ThemeMode.system, ThemeMode.dark];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return ToggleButtons(
      isSelected: _values.map((mode) => mode == themeMode).toList(),
      children: const [Icons.light_mode, Icons.smartphone, Icons.dark_mode]
          .map((icon) => Icon(icon))
          .toList(),
      onPressed: (index) {
        final value = _values[index];
        if (value != themeMode) {
          final isar = ref.read(isarProvider).valueOrNull;
          if (isar == null) return;
          setThemeMode(isar, value);
        }
      },
    );
  }
}
