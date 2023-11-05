import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../models/game.dart';
import '../../../models/location.dart';
import '../../../models/user_provider.dart';
import '../../../router/routes.dart';
import '../../../services/user_notifier.dart';
import '../../../utils/duration.dart';
import '../../../utils/iterable_extension.dart';

class GameTile extends StatelessWidget {
  const GameTile({
    required this.game,
    super.key,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMd().add_jm().format(game.date);
    return ExpansionTile(
      title: Text('$date @ ${game.location.label} (${game.duration.label})'),
      subtitle: Text([
        'Level: ',
        game.minLevel.value.toString(),
        ' - ',
        game.maxLevel.value.toString(),
        '  (',
        game.booked ? 'Booked' : 'Not booked',
        ') - ',
        '${game.price} SGD'
      ].join()),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Builder(builder: (context) {
            final color = IconTheme.of(context).color;
            final textStyle = TextStyle(color: color);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${max(game.playersNullSafe.length, game.numberOfPlayers)}/${game.numberOfPlayers}',
                  style: textStyle,
                ),
                if (game.numberOfWaitListPlayers > 0)
                  Text(
                    '${max(game.playersNullSafe.length - game.numberOfPlayers, 0)}/${game.numberOfWaitListPlayers}',
                    style: textStyle,
                  ),
              ],
            );
          }),
          const Icon(Icons.person),
        ],
      ),
      children: [
        _Creator(game: game),
        _Players(game: game),
        _EditButtons(game: game)
      ],
    );
  }
}

class _Creator extends ConsumerWidget {
  const _Creator({
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider(game.createdBy)).valueOrNull;
    final text = user?.fullName ?? '';
    return ListTile(
      title: Text('Creator: $text'),
    );
  }
}

class _Players extends ConsumerWidget {
  const _Players({
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberOfRows =
        game.totalNumberOfSpots + (game.numberOfWaitListPlayers > 0 ? 1 : 0);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Table(
        columnWidths: const {0: FixedColumnWidth(24)},
        children: List.generate(
          numberOfRows,
          (index) {
            if (index == game.numberOfPlayers) {
              return TableRow(
                children: [
                  const SizedBox.shrink(),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(),
                      ),
                      Text(
                        'Wait list',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const Expanded(
                        child: Divider(),
                      ),
                    ].separated(const SizedBox(width: 8)).toList(),
                  ),
                ],
              );
            }
            final effectiveIndex =
                index > game.numberOfPlayers ? index - 1 : index;
            return TableRow(
              children: [
                Text('${(effectiveIndex + 1).toString()}.'),
                if (effectiveIndex < game.playersNullSafe.length)
                  Text(ref
                          .watch(
                            userProvider(game.playersNullSafe[effectiveIndex]),
                          )
                          .valueOrNull
                          ?.fullName ??
                      '')
                else
                  const Text('-'),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _EditButtons extends ConsumerWidget {
  const _EditButtons({
    required this.game,
  });

  Future<void> _join(BuildContext context) async {
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
    Iterable<String> newPlayers = game.playersNullSafe.where((playerId) {
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
    }).toList();

    if (count < value) {
      newPlayers = newPlayers.followedBy(
        List.generate(value - count, (index) => userId),
      );
    }

    await FirebaseFirestore.instance.collection('games').doc(game.id).set(
      {
        'players': newPlayers.toList(),
      },
      SetOptions(merge: true),
    );

    if (hasRemovedSlots && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'You have removed yourself from some slot in the game. If you were not in the wait-list, send a message on whatsapp\n'
            'Either notify the player from the wait-list that will take your place warn the there is now an empty slot in the game.',
          ),
        ),
      );
    }
  }

  void _edit(BuildContext context) {
    GameRoute(id: game.id).go(context);
  }

  final Game game;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(loggedInUserProvider).user;
    if (user == null) return const SizedBox.shrink();
    final String? text;
    if (game.playersNullSafe.contains(user.id)) {
      text = 'Update';
    } else if (game.isFull) {
      text = null;
    } else {
      text = 'Join';
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (text != null)
            ElevatedButton(
              onPressed: () => _join(context),
              child: Text(text),
            ),
          if (game.createdBy == user.id)
            ElevatedButton.icon(
              onPressed: () => _edit(context),
              icon: const Icon(Icons.edit),
              label: const Text('Edit'),
            ),
        ].separated(const SizedBox(width: 8)).toList(),
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
