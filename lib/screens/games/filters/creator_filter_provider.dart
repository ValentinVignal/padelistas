import 'package:flutter_riverpod/flutter_riverpod.dart';

final creatorFilterProvider = Provider.autoDispose<Set<String>>((ref) {
  return const {};
});
