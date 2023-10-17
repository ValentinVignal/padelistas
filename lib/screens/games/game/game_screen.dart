import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/game.dart';
import '../../../models/game_provider.dart';
import '../../../models/user_provider.dart';
import '../../../services/user_notifier.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({
    required this.id,
    super.key,
  });

  final String id;

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final game = ref.watch(gameProvider(widget.id)).valueOrNull;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.titleMedium,
              children: [
                if (game != null)
                  TextSpan(
                    text:
                        '${game.playersNullSafe.length}/${game.numberOfPlayers} ',
                  ),
                const WidgetSpan(
                  child: Icon(Icons.person),
                ),
              ],
            ),
          ),
          ...game?.playersNullSafe.map(
                (playerId) {
                  return Consumer(builder: (context, ref, _) {
                    final user = ref.watch(userProvider(playerId)).valueOrNull;
                    final String userString;
                    if (user == null) {
                      userString = 'Player';
                    } else {
                      userString = '${user.firstName} ${user.lastName}';
                    }
                    return ListTile(
                      title: Text(userString),
                    );
                  });
                },
              ) ??
              const [],
          if (game != null &&
              ((game.playersNullSafe.length) < game.numberOfPlayers ||
                  game.playersNullSafe.contains(userNotifier.value!.id))) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final value = await showDialog<int>(
                  context: context,
                  builder: (_) => _SlotsDialog(
                    game: game,
                  ),
                );
                if (value == null) return;
                final userId = userNotifier.value!.id;
                FirebaseFirestore.instance
                    .collection('games')
                    .doc(game.id)
                    .update({
                  'players': game.playersNullSafe
                      .where((id) => id != userId)
                      .followedBy(List.generate(value, (index) => userId))
                      .toList(),
                });
              },
              child: Text(game.playersNullSafe.contains(userNotifier.value!.id)
                  ? 'Update'
                  : 'Join'),
            ),
          ],
        ],
      ),
    );
  }
}

class _SlotsDialog extends StatefulWidget {
  const _SlotsDialog({required this.game});

  final Game game;

  @override
  State<_SlotsDialog> createState() => _SlotsDialogState();
}

class _SlotsDialogState extends State<_SlotsDialog> {
  late int _value;

  late final int _max;

  @override
  void initState() {
    super.initState();
    final userID = userNotifier.value!.id;
    final alreadyTakenSlots =
        widget.game.playersNullSafe.where((id) => id == userID).length;

    _value = max(1, alreadyTakenSlots);
    _max = widget.game.numberOfPlayers -
        widget.game.playersNullSafe.length +
        alreadyTakenSlots;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('How many slots?'),
      content: DropdownButton(
        value: _value,
        onChanged: (value) {
          if (value == null) return;
          setState(() {
            _value = value;
          });
        },
        items: List.generate(
          _max + 1,
          (index) => DropdownMenuItem(value: index, child: Text('$index')),
        ).toList(),
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.of(context).pop(_value);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
