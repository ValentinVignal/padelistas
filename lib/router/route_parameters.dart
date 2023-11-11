import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_parameters.freezed.dart';

@freezed
class GamesRouteParameters with _$GamesRouteParameters {
  const factory GamesRouteParameters({
    @Default({}) Set<String> creator,
    @Default({}) Set<String> player,
    @Default(false) bool all,
  }) = _GamesRouteParameters;
}
