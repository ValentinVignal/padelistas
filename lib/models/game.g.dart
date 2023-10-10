// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Game _$$_GameFromJson(Map<String, dynamic> json) => _$_Game(
      id: json['id'] as String,
      location: $enumDecode(_$LocationEnumMap, json['location']),
      date: const DateToTimestampJsonConverter()
          .fromJson(json['date'] as Timestamp),
      duration: Duration(microseconds: json['duration'] as int),
      numberOfPlayers: json['numberOfPlayers'] as int,
      booked: json['booked'] as bool,
      price: (json['price'] as num).toDouble(),
      minLevel: const LevelJsonConverter().fromJson(json['minLevel'] as double),
      maxLevel: const LevelJsonConverter().fromJson(json['maxLevel'] as double),
    );

Map<String, dynamic> _$$_GameToJson(_$_Game instance) => <String, dynamic>{
      'location': _$LocationEnumMap[instance.location]!,
      'date': const DateToTimestampJsonConverter().toJson(instance.date),
      'duration': instance.duration.inMicroseconds,
      'numberOfPlayers': instance.numberOfPlayers,
      'booked': instance.booked,
      'price': instance.price,
      'minLevel': const LevelJsonConverter().toJson(instance.minLevel),
      'maxLevel': const LevelJsonConverter().toJson(instance.maxLevel),
    };

const _$LocationEnumMap = {
  Location.marinaSquare: 'marinaSquare',
  Location.ricochetSentosa: 'ricochetSentosa',
  Location.ricochetLaguna: 'ricochetLaguna',
};
