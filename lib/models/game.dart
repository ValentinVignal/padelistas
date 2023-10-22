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
    // It is what freezed recommends.
    //
    // ignore: invalid_annotation_target
    @JsonKey(includeIfNull: false) List<String>? players,
    required String createdBy,
    required int numberOfWaitListPlayers,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  factory Game.fromJsonDocument(String id, Json document) => Game.fromJson({
        ...document,
        'id': id,
      });

  const Game._();

  List<String> get playersNullSafe => players ?? const <String>[];

  /// `Map<String, String | bool>`.
  Json toSimpleJson() => {
        ...toJson(),
        'date': date.toIso8601String(),
        'booked': booked.toString()
      };

  int get totalNumberOfSpots => numberOfPlayers + numberOfWaitListPlayers;

  bool get isFull => playersNullSafe.length >= totalNumberOfSpots;
}
