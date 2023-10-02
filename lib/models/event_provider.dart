import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'event.dart';
import 'location.dart';

final _events = [
  Event(
    date: DateTime.now(),
    location: Location.marinaSquare,
  ),
  Event(
    date: DateTime.now().add(const Duration(days: 13)),
    location: Location.marinaSquare,
  ),
  Event(
    date: DateTime.now().add(const Duration(days: 5)),
    location: Location.ricochetLaguna,
  ),
  Event(
    date: DateTime.now().add(const Duration(days: 2)),
    location: Location.ricochetSentosa,
  ),
];

final eventsProvider = StreamProvider.autoDispose<List<Event>>((ref) async* {
  yield _events;
});