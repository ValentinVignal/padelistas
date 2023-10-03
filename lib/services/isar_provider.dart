import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:padelistas/services/settings/settings.dart';
import 'package:path_provider/path_provider.dart';

final isarProvider = FutureProvider<Isar>((ref) async {
  final dir = kIsWeb
      ? Isar.sqliteInMemory
      : (await getApplicationDocumentsDirectory()).path;
  const engine = kIsWeb ? IsarEngine.sqlite : IsarEngine.isar;
  final isar = Isar.open(
    schemas: [SimpleSettingSchema],
    directory: dir,
    engine: engine,
  );
  return isar;
});
