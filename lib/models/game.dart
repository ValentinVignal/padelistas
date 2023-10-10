import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/date_to_timestamp_json_converter.dart';
import '../utils/json.dart';
import 'level.dart';
import 'location.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
class Game with _$Game {
  const factory Game({
    // It is what freezed recommends.
    //
    // ignore: invalid_annotation_target
    @JsonKey(includeToJson: false) required String id,
    required Location location,
    @DateToTimestampJsonConverter() required DateTime date,
    required Duration duration,
    required int numberOfPlayers,
    required bool booked,
    required double price,
    @LevelJsonConverter() required Level minLevel,
    @LevelJsonConverter() required Level maxLevel,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  factory Game.fromJsonDocument(String id, Json document) => Game.fromJson({
        ...document,
        'id': id,
      });

  const Game._();
}
