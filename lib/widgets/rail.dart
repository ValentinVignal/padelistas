import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../router/routes.dart';
import '../services/user_notifier.dart';

class _RailKey extends Key with EquatableMixin {
  const _RailKey() : super.empty();

  @override
  List<Object?> get props => const [];
}

class Rail extends ConsumerWidget {
  const Rail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = GoRouterState.of(context).uri.pathSegments.firstOrNull;
    final isAdmin = ref.watch(loggedInUserProvider).isAdmin;

    int currentIndex;
    switch (path) {
      case UsersRoute.path:
        currentIndex = 0;
        break;
      case SettingsRoute.path:
        currentIndex = 2;
        break;
      case GamesRoute.path:
      default:
        currentIndex = 1;
        break;
    }
    if (!isAdmin) {
      assert(currentIndex != 0,
          'Non-admins should not be able to access the Users screen.');
      currentIndex--;
    }

    return Hero(
      tag: const _RailKey(),
      child: NavigationRail(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          final effectiveIndex = isAdmin ? index : index + 1;
          assert(effectiveIndex >= 0 && effectiveIndex <= 2);
          switch (effectiveIndex) {
            case 0:
              const UsersRoute().go(context);
              break;
            case 1:
              const GamesRoute().go(context);
              break;
            case 2:
              const SettingsRoute().go(context);
              break;
          }
        },
        destinations: [
          if (isAdmin)
            const NavigationRailDestination(
              icon: Icon(Icons.people),
              label: Text('Users'),
            ),
          const NavigationRailDestination(
            icon: Icon(Icons.sports_tennis),
            label: Text('Games'),
          ),
          const NavigationRailDestination(
            icon: Icon(Icons.settings),
            label: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
