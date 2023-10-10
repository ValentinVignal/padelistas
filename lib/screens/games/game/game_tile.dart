import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/game.dart';
import '../../../models/location.dart';
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
      leading: Builder(
        builder: (context) {
          final textTheme = DefaultTextStyle.of(context).style;
          return RichText(
            text: TextSpan(
              style: textTheme,
              children: [
                const TextSpan(text: '0/'),
                TextSpan(text: game.numberOfPlayers.toString()),
                const WidgetSpan(child: Icon(Icons.person)),
              ],
            ),
          );
        },
      ),
      trailing: Builder(
        builder: (context) {
          final textTheme = DefaultTextStyle.of(context).style;
          return RichText(
            text: TextSpan(
              style: textTheme,
              children: [
                TextSpan(text: game.price.toString()),
                const TextSpan(text: ' SGD'),
              ],
            ),
          );
        },
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Coming soon')),
        );
      },
    );
  }
}
