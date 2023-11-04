import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/game.dart';
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
    return const Placeholder();
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
