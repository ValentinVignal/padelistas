import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/game.dart';
import '../../../models/game_provider.dart';
import '../../../models/user_provider.dart';
import '../../../services/user_notifier.dart';
import '../../../utils/iterable_extension.dart';

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
          Consumer(
            builder: (context, ref, _) {
              final String text;
              if (game != null) {
                final user =
                    ref.watch(userProvider(game.createdBy)).valueOrNull;
                text = user?.fullName ?? '';
              } else {
                text = '';
              }
              return ListTile(
                title: Text('Creator: $text'),
              );
            },
          ),
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
          ...game?.playersNullSafe.mapIndexed(
                (index, playerId) {
                  return Consumer(
                    builder: (context, ref, _) {
                      final user =
                          ref.watch(userProvider(playerId)).valueOrNull;
                      final String userString;
                      if (user == null) {
                        userString = 'Player';
                      } else {
                        userString = user.fullName;
                      }
                      final child = ListTile(
                        title: Text(userString),
                      );
                      if (index != game.numberOfPlayers) {
                        return child;
                      }
                      return Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child: Divider(),
                              ),
                              const Text('Wait list'),
                              const Expanded(
                                child: Divider(),
                              ),
                            ].separated(const SizedBox(width: 8)).toList(),
                          ),
                          child,
                        ],
                      );
                    },
                  );
                },
              ) ??
              const [],
          if (game != null &&
              (!game.isFull ||
                  game.playersNullSafe.contains(userNotifier.user!.id))) ...[
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
                final userId = userNotifier.user!.id;
                var count = 0;
                var hasRemovedSlots = false;
                var newPlayers = game.playersNullSafe.where((playerId) {
                  if (playerId == userId) {
                    count++;
                    if (count <= value) {
                      return true;
                    } else {
                      hasRemovedSlots = true;
                      return false;
                    }
                  } else {
                    return true;
                  }
                });

                if (count < value) {
                  newPlayers = newPlayers.followedBy(
                    List.generate(value - count, (index) => userId),
                  );
                }

                await FirebaseFirestore.instance
                    .collection('games')
                    .doc(game.id)
                    .update({
                  'players': newPlayers.toList(),
                });

                if (hasRemovedSlots && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'You have removed yourself from some slot in the game. If you were not in the wait-list, send a message on whatsapp\n'
                        'Either notify the player from the wait-list that will take your place warn the there is now an empty slot in the game.',
                      ),
                    ),
                  );
                }
              },
              child: Text(game.playersNullSafe.contains(userNotifier.user!.id)
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
    final userID = userNotifier.user!.id;
    final alreadyTakenSlots =
        widget.game.playersNullSafe.where((id) => id == userID).length;

    _value = max(1, alreadyTakenSlots);
    _max = widget.game.totalNumberOfSpots -
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
