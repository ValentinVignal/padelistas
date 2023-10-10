import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../models/game.dart';
import '../../../models/level.dart';
import '../../../models/location.dart';
import '../../../utils/bool.dart';
import '../../../utils/iterable_extension.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  Location? location;

  DateTime? date;

  TimeOfDay? time;

  var duration = const Duration(hours: 1, minutes: 30);

  final _numberOfPlayersController = TextEditingController(text: '4');

  var _booked = true;

  final _priceController = TextEditingController();

  var _minLevel = Level.zero;
  var _maxLevel = Level.seven;

  bool _canSave() {
    return location != null && date != null && time != null;
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? now,
      firstDate: now,
      lastDate: now.add(
        const Duration(days: 7 * 4),
      ),
    );
    if (newDate != null) {
      setState(() {
        date = newDate;
      });
      if (!mounted) return;
      await _pickTime(context);
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? TimeOfDay.now(),
    );

    if (newTime != null) {
      setState(() {
        time = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          DropdownButton(
            onChanged: (value) {
              setState(() {
                location = value;
              });
            },
            value: location,
            hint: const Text('Location'),
            items: Location.values
                .map((location) => DropdownMenuItem(
                      value: location,
                      child: Text(location.label),
                    ))
                .toList(),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: InputDatePickerFormField(
                    initialDate: date,
                    firstDate: now,
                    lastDate: now.add(
                      const Duration(days: 7 * 4),
                    ),
                    onDateSaved: (value) {
                      setState(() {
                        date = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _pickDate(context);
                  },
                  icon: const Icon(Icons.calendar_today),
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(time?.format(context) ?? ''),
                ),
                IconButton(
                  onPressed: () {
                    _pickTime(context);
                  },
                  icon: const Icon(Icons.schedule),
                ),
              ],
            ),
          ),
          Slider(
            label:
                'Duration: ${duration.inHours}h${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}min',
            value: duration.inMinutes.toDouble(),
            min: 60,
            max: 180,
            divisions: 4,
            onChanged: (value) {
              setState(() {
                duration = Duration(minutes: value.toInt());
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(label: Text('Number of players')),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Required';
              if (int.tryParse(value!) == null) return 'Invalid number';

              return null;
            },
            controller: _numberOfPlayersController,
          ),
          Checkbox(
            value: _booked,
            onChanged: (value) {
              setState(() {
                _booked = value!;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(label: Text('Price')),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]|\.')),
            ],
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Required';
              if (double.tryParse(value!) == null) return 'Invalid number';

              return null;
            },
            controller: _priceController,
          ),
          RangeSlider(
            labels: RangeLabels(
              'Min level: ${_minLevel.fullLabel}',
              'Max level: ${_maxLevel.fullLabel}',
            ),
            values: RangeValues(
              _minLevel.value.toDouble(),
              _maxLevel.value.toDouble(),
            ),
            min: Level.zero.value,
            max: Level.seven.value,
            divisions: Level.values.length - 1,
            onChanged: (value) {
              setState(() {
                _minLevel = Level.fromValue(value.start);
                _maxLevel = Level.fromValue(value.end);
              });
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _canSave().nullIfFalse(() async {
                  final game = Game(
                    id: '',
                    date: date!.add(
                      Duration(
                        hours: time!.hour,
                        minutes: time!.minute,
                      ),
                    ),
                    location: location!,
                    duration: duration,
                    numberOfPlayers: int.parse(
                      _numberOfPlayersController.text,
                    ),
                    booked: _booked,
                    price: double.parse(_priceController.text),
                    minLevel: _minLevel,
                    maxLevel: _maxLevel,
                  );

                  await FirebaseFirestore.instance.collection('games').add(
                        game.toJson(),
                      );
                  if (!mounted) return;

                  Navigator.of(context).pop();
                }),
                child: const Text('Create'),
              ),
            ],
          ),
        ].separated(const SizedBox(height: 16)).toList(),
      ),
    );
  }
}
