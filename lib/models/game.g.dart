// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameImpl _$$GameImplFromJson(Map<String, dynamic> json) => _$GameImpl(
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
      players:
          (json['players'] as List<dynamic>?)?.map((e) => e as String).toList(),
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$$GameImplToJson(_$GameImpl instance) =>
    <String, dynamic>{
      'location': _$LocationEnumMap[instance.location]!,
      'date': const DateToTimestampJsonConverter().toJson(instance.date),
      'duration': instance.duration.inMicroseconds,
      'numberOfPlayers': instance.numberOfPlayers,
      'booked': instance.booked,
      'price': instance.price,
      'minLevel': const LevelJsonConverter().toJson(instance.minLevel),
      'maxLevel': const LevelJsonConverter().toJson(instance.maxLevel),
      'players': instance.players,
      'createdBy': instance.createdBy,
    };

const _$LocationEnumMap = {
  Location.marinaSquare: 'marinaSquare',
  Location.ricochetSentosa: 'ricochetSentosa',
  Location.ricochetLaguna: 'ricochetLaguna',
};
