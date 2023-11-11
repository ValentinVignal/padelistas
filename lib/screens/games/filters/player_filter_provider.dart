import 'package:flutter_riverpod/flutter_riverpod.dart';

final playerFilterProvider = Provider.autoDispose<Set<String>>((ref) {
  return const {};
});
