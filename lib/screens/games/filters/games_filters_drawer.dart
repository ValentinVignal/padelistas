import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes.dart';
import '../../../services/user_notifier.dart';
import 'games_filter_provider.dart';

class GamesFiltersDrawer extends ConsumerWidget {
  const GamesFiltersDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameters = ref.watch(gamesRouteParametersProvider);
    final userId = ref.watch(loggedInUserProvider).user?.id;
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SwitchListTile.adaptive(
            title: const Text('Show only the games I created'),
            value: parameters.creator.contains(userId),
            onChanged: (value) {
              GoRouter.of(context).go(
                GamesRoute.fromParameters(
                  parameters.copyWith(creator: {if (value) userId!}),
                ).location,
              );
            },
          ),
          SwitchListTile.adaptive(
            title: const Text('Show only the games I have joined'),
            value: parameters.player.contains(userId),
            onChanged: (value) {
              GoRouter.of(context).go(
                GamesRoute.fromParameters(
                  parameters.copyWith(player: {if (value) userId!}),
                ).location,
              );
            },
          ),
          SwitchListTile.adaptive(
            title: const Text('Include past games'),
            value: parameters.all,
            onChanged: (value) {
              GoRouter.of(context).go(
                GamesRoute.fromParameters(
                  parameters.copyWith(all: value),
                ).location,
              );
            },
          ),
        ],
      ),
    );
  }
}
