import 'package:isar/isar.dart';

part 'settings.g.dart';

@collection
class SimpleSetting {
  const SimpleSetting({
    required this.id,
    this.value,
  });
  final String id;

  final String? value;
}
