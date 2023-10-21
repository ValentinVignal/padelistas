import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../models/games_provider.dart';
import '../../router/routes.dart';
import '../../services/user_notifier.dart';
import '../../utils/date.dart';
import 'game/game_tile.dart';

class GamesScreen extends ConsumerWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final games = ref.watch(gamesProvider).valueOrNull ?? const [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
        actions: const [_MoreButton()],
      ),
      body: ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          final tile = GameTile(game: game);
          if (index == 0 || !games[index - 1].date.isSameDayAs(game.date)) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _DateHeader(date: game.date),
                tile,
              ],
            );
          }
          return tile;
        },
      ),
      floatingActionButton: const _FAB(),
    );
  }
}

enum _MoreButtonValue {
  usersToApprove,
  settings,
}

class _MoreButton extends ConsumerWidget {
  const _MoreButton();

  void _onSelected(BuildContext context, _MoreButtonValue value) {
    switch (value) {
      case _MoreButtonValue.usersToApprove:
        const UsersRoute().push(context);
        break;
      case _MoreButtonValue.settings:
        const SettingsRoute().push(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(loggedInUserProvider).isAdmin;
    return PopupMenuButton(
      onSelected: (value) => _onSelected(context, value),
      itemBuilder: (context) {
        return [
          if (isAdmin)
            const PopupMenuItem(
              value: _MoreButtonValue.usersToApprove,
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text('Users'),
              ),
            ),
          const PopupMenuItem(
            value: _MoreButtonValue.settings,
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ),
        ];
      },
    );
  }
}

class _FAB extends ConsumerWidget {
  const _FAB();

  void _createGame(BuildContext context) {
    const NewGameRoute().push(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        _createGame(context);
      },
      child: const Icon(Icons.add),
    );
  }
}

class _DateHeader extends StatelessWidget {
  const _DateHeader({
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chip(
        label: Text(
          DateFormat.yMMMd().format(date),
        ),
      ),
    );
  }
}