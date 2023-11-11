import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether or not all the games should be shown.
final allGamesFilterProvider = Provider.autoDispose<bool>((ref) {
  return false;
});
