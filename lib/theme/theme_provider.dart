import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:padelistas/services/settings/settings.dart';

import '../services/isar_provider.dart';

const _key = 'themeMode';

final _themeModeAsyncProvider = FutureProvider<SimpleSetting?>((ref) async {
  final isar = await ref.watch(isarProvider.future);

  final setting = isar.simpleSettings.get(_key);
  final subscription =
      isar.simpleSettings.watchObjectLazy(_key).listen((event) {
    ref.invalidateSelf();
  });
  ref.onDispose(subscription.cancel);
  return setting;
});

final themeModeProvider = Provider<ThemeMode>((ref) {
  final value = ref.watch(_themeModeAsyncProvider).valueOrNull?.value;
  if (value != null) {
    return ThemeMode.values.byName(value);
  } else {
    return ThemeMode.system;
  }
});

Future<void> setThemeMode(Isar isar, ThemeMode themeMode) {
  return isar.writeAsync(
    (isar) =>
        isar.simpleSettings.put(SimpleSetting(id: _key, value: themeMode.name)),
  );
}
