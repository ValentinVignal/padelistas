import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/game.dart';
import '../../../models/location.dart';
import '../../../router/routes.dart';
import '../../../utils/duration.dart';

class GameTile extends StatelessWidget {
  const GameTile({
    required this.game,
    super.key,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMd().add_jm().format(game.date);
    return ListTile(
      title: Text('$date @ ${game.location.label} (${game.duration.label})'),
      subtitle: Builder(
        builder: (context) {
          final textTheme = DefaultTextStyle.of(context).style;
          return RichText(
            text: TextSpan(
              style: textTheme,
              children: [
                const TextSpan(text: 'Level: '),
                TextSpan(text: game.minLevel.value.toString()),
                const TextSpan(text: ' - '),
                TextSpan(text: game.maxLevel.value.toString()),
                const TextSpan(text: '  ('),
                TextSpan(text: game.booked ? 'Booked' : 'Not booked'),
                const TextSpan(text: ')'),
              ],
            ),
          );
        },
      ),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${max(game.playersNullSafe.length, game.numberOfPlayers)}/${game.numberOfPlayers}',
              ),
              if (game.numberOfWaitListPlayers > 0)
                Text(
                  '${max(game.playersNullSafe.length - game.numberOfPlayers, 0)}/${game.numberOfWaitListPlayers}',
                ),
            ],
          ),
          const Icon(Icons.person),
        ],
      ),
      trailing: Text('${game.price} SGD'),
      onTap: () {
        GameRoute(id: game.id).push(context);
      },
    );
  }
}
