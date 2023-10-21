// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Game _$GameFromJson(Map<String, dynamic> json) {
  return _Game.fromJson(json);
}

/// @nodoc
mixin _$Game {
// It is what freezed recommends.
//
// ignore: invalid_annotation_target
  @JsonKey(includeToJson: false)
  String get id => throw _privateConstructorUsedError;
  Location get location => throw _privateConstructorUsedError;
  @DateToTimestampJsonConverter()
  DateTime get date => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  int get numberOfPlayers => throw _privateConstructorUsedError;
  bool get booked => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  @LevelJsonConverter()
  Level get minLevel => throw _privateConstructorUsedError;
  @LevelJsonConverter()
  Level get maxLevel => throw _privateConstructorUsedError;
  List<String>? get players => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameCopyWith<Game> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res, Game>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      Location location,
      @DateToTimestampJsonConverter() DateTime date,
      Duration duration,
      int numberOfPlayers,
      bool booked,
      double price,
      @LevelJsonConverter() Level minLevel,
      @LevelJsonConverter() Level maxLevel,
      List<String>? players,
      String createdBy});
}

/// @nodoc
class _$GameCopyWithImpl<$Res, $Val extends Game>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? location = null,
    Object? date = null,
    Object? duration = null,
    Object? numberOfPlayers = null,
    Object? booked = null,
    Object? price = null,
    Object? minLevel = null,
    Object? maxLevel = null,
    Object? players = freezed,
    Object? createdBy = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      numberOfPlayers: null == numberOfPlayers
          ? _value.numberOfPlayers
          : numberOfPlayers // ignore: cast_nullable_to_non_nullable
              as int,
      booked: null == booked
          ? _value.booked
          : booked // ignore: cast_nullable_to_non_nullable
              as bool,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      minLevel: null == minLevel
          ? _value.minLevel
          : minLevel // ignore: cast_nullable_to_non_nullable
              as Level,
      maxLevel: null == maxLevel
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as Level,
      players: freezed == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameImplCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$$GameImplCopyWith(
          _$GameImpl value, $Res Function(_$GameImpl) then) =
      __$$GameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      Location location,
      @DateToTimestampJsonConverter() DateTime date,
      Duration duration,
      int numberOfPlayers,
      bool booked,
      double price,
      @LevelJsonConverter() Level minLevel,
      @LevelJsonConverter() Level maxLevel,
      List<String>? players,
      String createdBy});
}

/// @nodoc
class __$$GameImplCopyWithImpl<$Res>
    extends _$GameCopyWithImpl<$Res, _$GameImpl>
    implements _$$GameImplCopyWith<$Res> {
  __$$GameImplCopyWithImpl(_$GameImpl _value, $Res Function(_$GameImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? location = null,
    Object? date = null,
    Object? duration = null,
    Object? numberOfPlayers = null,
    Object? booked = null,
    Object? price = null,
    Object? minLevel = null,
    Object? maxLevel = null,
    Object? players = freezed,
    Object? createdBy = null,
  }) {
    return _then(_$GameImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      numberOfPlayers: null == numberOfPlayers
          ? _value.numberOfPlayers
          : numberOfPlayers // ignore: cast_nullable_to_non_nullable
              as int,
      booked: null == booked
          ? _value.booked
          : booked // ignore: cast_nullable_to_non_nullable
              as bool,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      minLevel: null == minLevel
          ? _value.minLevel
          : minLevel // ignore: cast_nullable_to_non_nullable
              as Level,
      maxLevel: null == maxLevel
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as Level,
      players: freezed == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameImpl extends _Game {
  const _$GameImpl(
      {@JsonKey(includeToJson: false) required this.id,
      required this.location,
      @DateToTimestampJsonConverter() required this.date,
      required this.duration,
      required this.numberOfPlayers,
      required this.booked,
      required this.price,
      @LevelJsonConverter() required this.minLevel,
      @LevelJsonConverter() required this.maxLevel,
      final List<String>? players,
      required this.createdBy})
      : _players = players,
        super._();

  factory _$GameImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameImplFromJson(json);

// It is what freezed recommends.
//
// ignore: invalid_annotation_target
  @override
  @JsonKey(includeToJson: false)
  final String id;
  @override
  final Location location;
  @override
  @DateToTimestampJsonConverter()
  final DateTime date;
  @override
  final Duration duration;
  @override
  final int numberOfPlayers;
  @override
  final bool booked;
  @override
  final double price;
  @override
  @LevelJsonConverter()
  final Level minLevel;
  @override
  @LevelJsonConverter()
  final Level maxLevel;
  final List<String>? _players;
  @override
  List<String>? get players {
    final value = _players;
    if (value == null) return null;
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String createdBy;

  @override
  String toString() {
    return 'Game(id: $id, location: $location, date: $date, duration: $duration, numberOfPlayers: $numberOfPlayers, booked: $booked, price: $price, minLevel: $minLevel, maxLevel: $maxLevel, players: $players, createdBy: $createdBy)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.numberOfPlayers, numberOfPlayers) ||
                other.numberOfPlayers == numberOfPlayers) &&
            (identical(other.booked, booked) || other.booked == booked) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.minLevel, minLevel) ||
                other.minLevel == minLevel) &&
            (identical(other.maxLevel, maxLevel) ||
                other.maxLevel == maxLevel) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      location,
      date,
      duration,
      numberOfPlayers,
      booked,
      price,
      minLevel,
      maxLevel,
      const DeepCollectionEquality().hash(_players),
      createdBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      __$$GameImplCopyWithImpl<_$GameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameImplToJson(
      this,
    );
  }
}

abstract class _Game extends Game {
  const factory _Game(
      {@JsonKey(includeToJson: false) required final String id,
      required final Location location,
      @DateToTimestampJsonConverter() required final DateTime date,
      required final Duration duration,
      required final int numberOfPlayers,
      required final bool booked,
      required final double price,
      @LevelJsonConverter() required final Level minLevel,
      @LevelJsonConverter() required final Level maxLevel,
      final List<String>? players,
      required final String createdBy}) = _$GameImpl;
  const _Game._() : super._();

  factory _Game.fromJson(Map<String, dynamic> json) = _$GameImpl.fromJson;

  @override // It is what freezed recommends.
//
// ignore: invalid_annotation_target
  @JsonKey(includeToJson: false)
  String get id;
  @override
  Location get location;
  @override
  @DateToTimestampJsonConverter()
  DateTime get date;
  @override
  Duration get duration;
  @override
  int get numberOfPlayers;
  @override
  bool get booked;
  @override
  double get price;
  @override
  @LevelJsonConverter()
  Level get minLevel;
  @override
  @LevelJsonConverter()
  Level get maxLevel;
  @override
  List<String>? get players;
  @override
  String get createdBy;
  @override
  @JsonKey(ignore: true)
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
