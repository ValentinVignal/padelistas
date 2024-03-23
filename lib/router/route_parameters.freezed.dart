// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_parameters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GamesRouteParameters {
  Set<String> get creator => throw _privateConstructorUsedError;
  Set<String> get player => throw _privateConstructorUsedError;
  bool get all => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GamesRouteParametersCopyWith<GamesRouteParameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GamesRouteParametersCopyWith<$Res> {
  factory $GamesRouteParametersCopyWith(GamesRouteParameters value,
          $Res Function(GamesRouteParameters) then) =
      _$GamesRouteParametersCopyWithImpl<$Res, GamesRouteParameters>;
  @useResult
  $Res call({Set<String> creator, Set<String> player, bool all});
}

/// @nodoc
class _$GamesRouteParametersCopyWithImpl<$Res,
        $Val extends GamesRouteParameters>
    implements $GamesRouteParametersCopyWith<$Res> {
  _$GamesRouteParametersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? creator = null,
    Object? player = null,
    Object? all = null,
  }) {
    return _then(_value.copyWith(
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      all: null == all
          ? _value.all
          : all // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GamesRouteParametersImplCopyWith<$Res>
    implements $GamesRouteParametersCopyWith<$Res> {
  factory _$$GamesRouteParametersImplCopyWith(_$GamesRouteParametersImpl value,
          $Res Function(_$GamesRouteParametersImpl) then) =
      __$$GamesRouteParametersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Set<String> creator, Set<String> player, bool all});
}

/// @nodoc
class __$$GamesRouteParametersImplCopyWithImpl<$Res>
    extends _$GamesRouteParametersCopyWithImpl<$Res, _$GamesRouteParametersImpl>
    implements _$$GamesRouteParametersImplCopyWith<$Res> {
  __$$GamesRouteParametersImplCopyWithImpl(_$GamesRouteParametersImpl _value,
      $Res Function(_$GamesRouteParametersImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? creator = null,
    Object? player = null,
    Object? all = null,
  }) {
    return _then(_$GamesRouteParametersImpl(
      creator: null == creator
          ? _value._creator
          : creator // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      player: null == player
          ? _value._player
          : player // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      all: null == all
          ? _value.all
          : all // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$GamesRouteParametersImpl implements _GamesRouteParameters {
  const _$GamesRouteParametersImpl(
      {final Set<String> creator = const {},
      final Set<String> player = const {},
      this.all = false})
      : _creator = creator,
        _player = player;

  final Set<String> _creator;
  @override
  @JsonKey()
  Set<String> get creator {
    if (_creator is EqualUnmodifiableSetView) return _creator;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_creator);
  }

  final Set<String> _player;
  @override
  @JsonKey()
  Set<String> get player {
    if (_player is EqualUnmodifiableSetView) return _player;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_player);
  }

  @override
  @JsonKey()
  final bool all;

  @override
  String toString() {
    return 'GamesRouteParameters(creator: $creator, player: $player, all: $all)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GamesRouteParametersImpl &&
            const DeepCollectionEquality().equals(other._creator, _creator) &&
            const DeepCollectionEquality().equals(other._player, _player) &&
            (identical(other.all, all) || other.all == all));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_creator),
      const DeepCollectionEquality().hash(_player),
      all);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GamesRouteParametersImplCopyWith<_$GamesRouteParametersImpl>
      get copyWith =>
          __$$GamesRouteParametersImplCopyWithImpl<_$GamesRouteParametersImpl>(
              this, _$identity);
}

abstract class _GamesRouteParameters implements GamesRouteParameters {
  const factory _GamesRouteParameters(
      {final Set<String> creator,
      final Set<String> player,
      final bool all}) = _$GamesRouteParametersImpl;

  @override
  Set<String> get creator;
  @override
  Set<String> get player;
  @override
  bool get all;
  @override
  @JsonKey(ignore: true)
  _$$GamesRouteParametersImplCopyWith<_$GamesRouteParametersImpl>
      get copyWith => throw _privateConstructorUsedError;
}
