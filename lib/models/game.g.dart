// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Game _$$_GameFromJson(Map<String, dynamic> json) => _$_Game(
      id: json['id'] as String,
      location: $enumDecode(_$LocationEnumMap, json['location']),
      date: DateTime.parse(json['date'] as String),
      duration: Duration(microseconds: json['duration'] as int),
      numberOfPlayers: json['numberOfPlayers'] as int,
      booked: json['booked'] as bool,
      price: (json['price'] as num).toDouble(),
      minLevel: $enumDecode(_$LevelEnumMap, json['minLevel']),
      maxLevel: $enumDecode(_$LevelEnumMap, json['maxLevel']),
    );

Map<String, dynamic> _$$_GameToJson(_$_Game instance) => <String, dynamic>{
      'location': _$LocationEnumMap[instance.location]!,
      'date': instance.date.toIso8601String(),
      'duration': instance.duration.inMicroseconds,
      'numberOfPlayers': instance.numberOfPlayers,
      'booked': instance.booked,
      'price': instance.price,
      'minLevel': _$LevelEnumMap[instance.minLevel]!,
      'maxLevel': _$LevelEnumMap[instance.maxLevel]!,
    };

const _$LocationEnumMap = {
  Location.marinaSquare: 'marinaSquare',
  Location.ricochetSentosa: 'ricochetSentosa',
  Location.ricochetLaguna: 'ricochetLaguna',
};

const _$LevelEnumMap = {
  Level.zero: 'zero',
  Level.zeroPointFive: 'zeroPointFive',
  Level.one: 'one',
  Level.onePointFive: 'onePointFive',
  Level.tow: 'tow',
  Level.towPointFive: 'towPointFive',
  Level.three: 'three',
  Level.threePointFive: 'threePointFive',
  Level.four: 'four',
  Level.fourPointFive: 'fourPointFive',
  Level.five: 'five',
  Level.fivePointFive: 'fivePointFive',
  Level.six: 'six',
  Level.sixPointFive: 'sixPointFive',
  Level.seven: 'seven',
};
