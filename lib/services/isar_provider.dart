import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:padelistas/services/settings/settings.dart';
import 'package:path_provider/path_provider.dart';

final isarProvider = FutureProvider<Isar>((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = Isar.open(
    schemas: [SimpleSettingSchema],
    directory: dir.path,
  );
  return isar;
});
