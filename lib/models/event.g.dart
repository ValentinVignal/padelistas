// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
      date: DateTime.parse(json['date'] as String),
      location: $enumDecode(_$LocationEnumMap, json['location']),
    );

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'location': _$LocationEnumMap[instance.location]!,
    };

const _$LocationEnumMap = {
  Location.marinaSquare: 'marinaSquare',
  Location.ricochetSentosa: 'ricochetSentosa',
  Location.ricochetLaguna: 'ricochetLaguna',
};
