import 'package:freezed_annotation/freezed_annotation.dart';

import 'location.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
class Event with _$Event {
  const factory Event({
    required DateTime date,
    required Location location,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  const Event._();
}
