import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../router/route_parameters.dart';
import 'all_games_filter_provider.dart';
import 'creator_filter_provider.dart';
import 'player_filter_provider.dart';

final gamesRouteParametersProvider = Provider.autoDispose<GamesRouteParameters>(
  (ref) {
    return GamesRouteParameters(
      creator: ref.watch(creatorFilterProvider),
      player: ref.watch(playerFilterProvider),
      all: ref.watch(allGamesFilterProvider),
    );
  },
  dependencies: [
    creatorFilterProvider,
    playerFilterProvider,
    allGamesFilterProvider
  ],
);
