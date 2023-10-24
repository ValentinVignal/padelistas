import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../services/isar_provider.dart';
import '../services/settings/settings.dart';

const _key = 'themeMode';

final _themeModeAsyncProvider = FutureProvider<SimpleSetting?>(
  (ref) async {
    final isar = await ref.watch(isarProvider.future);
    final SimpleSetting? setting;
    if (!kIsWeb) {
      setting = await isar.simpleSettings.getAsync(_key);
      // Watchers are not supported on web yet.
      final subscription = isar.simpleSettings.watchObjectLazy(_key).listen(
        (event) {
          ref.invalidateSelf();
        },
      );
      ref.onDispose(subscription.cancel);
    } else {
      setting = isar.simpleSettings
          .get(_key); // Async methods are not supported on web yet.
    }
    return setting;
  },
  dependencies: [isarProvider],
);

final themeModeProvider = Provider<ThemeMode>(
  (ref) {
    final value = ref.watch(_themeModeAsyncProvider).valueOrNull?.value;
    if (value != null) {
      return ThemeMode.values.byName(value);
    } else {
      return ThemeMode.system;
    }
  },
  dependencies: [_themeModeAsyncProvider],
);

void setThemeMode({
  required WidgetRef ref, // Because the watchers are not supported on web yet.
  required Isar isar,
  required ThemeMode themeMode,
}) {
  // Cannot use `Isar.writeAsync` because it is not supported on web yet.
  isar.write(
    (isar) => isar.simpleSettings.put(
      SimpleSetting(id: _key, value: themeMode.name),
    ),
  );
  if (kIsWeb) {
    // The watchers are not supported yet
    ref.invalidate(_themeModeAsyncProvider);
  }
}
