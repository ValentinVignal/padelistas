import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../models/game.dart';
import '../../../models/level.dart';
import '../../../models/location.dart';
import '../../../services/user_notifier.dart';
import '../../../utils/bool.dart';
import '../../../utils/duration.dart';
import '../../../utils/iterable_extension.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  Location? _location;

  DateTime? _date;

  TimeOfDay? _time;

  var _duration = const Duration(hours: 1, minutes: 30);

  final _numberOfPlayersController = TextEditingController(text: '4');

  var _booked = true;

  final _priceController = TextEditingController();

  var _minLevel = Level.zero;
  var _maxLevel = Level.seven;

  final _formKey = GlobalKey<FormState>();

  bool _canSave() {
    return _location != null &&
        _date != null &&
        _time != null &&
        int.tryParse(_numberOfPlayersController.text) != null;
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: _date ?? now,
      firstDate: now,
      lastDate: now.add(
        const Duration(days: 7 * 4),
      ),
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
      if (!mounted) return;
      await _pickTime(context);
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: _time ?? TimeOfDay.now(),
    );

    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateText =
        _date == null ? '* Date' : DateFormat.yMMMd().format(_date!);
    final timeText = _time?.format(context) ?? '* Time';
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: DropdownButtonFormField(
                        validator: (value) {
                          if (value == null) return 'Required';
                          return null;
                        },
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            _location = value;
                          });
                          _pickDate(context);
                        },
                        value: _location,
                        hint: const Text('* Location'),
                        items: Location.values
                            .map((location) => DropdownMenuItem(
                                  value: location,
                                  child: Text(location.label),
                                ))
                            .toList(),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _pickDate(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today),
                                    Expanded(
                                      child: Center(
                                        child: Text(dateText),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _pickTime(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.schedule),
                                    Expanded(
                                      child: Center(
                                        child: Text(timeText),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Duration (${_duration.label})',
                  enabledBorder: InputBorder.none,
                ),
                child: Slider(
                  label: 'Duration: ${_duration.label}',
                  value: _duration.inMinutes.toDouble(),
                  min: 60,
                  max: 180,
                  divisions: 4,
                  onChanged: (value) {
                    setState(() {
                      _duration = Duration(minutes: value.toInt());
                    });
                  },
                ),
              ),
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Level (${_minLevel.value} - ${_maxLevel.value})',
                  enabledBorder: InputBorder.none,
                ),
                child: RangeSlider(
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
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('* Number of players'),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value?.isEmpty ?? true) return 'Required';
                        if (int.tryParse(value!) == null) {
                          return 'Invalid number';
                        }

                        return null;
                      },
                      controller: _numberOfPlayersController,
                    ),
                  ),
                  Expanded(
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Booked?',
                        enabledBorder: InputBorder.none,
                      ),
                      child: Checkbox(
                        value: _booked,
                        onChanged: (value) {
                          setState(() {
                            _booked = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: const InputDecoration(label: Text('Price')),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]|\.')),
                      ],
                      validator: (value) {
                        if (value?.isEmpty ?? true) return null;
                        if (double.tryParse(value!) == null) {
                          return 'Invalid number';
                        }

                        return null;
                      },
                      controller: _priceController,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _canSave().nullIfFalse(() async {
                      if (!_formKey.currentState!.validate()) return;
                      final game = Game(
                        id: '',
                        date: _date!.add(
                          Duration(
                            hours: _time!.hour,
                            minutes: _time!.minute,
                          ),
                        ),
                        location: _location!,
                        duration: _duration,
                        numberOfPlayers: int.parse(
                          _numberOfPlayersController.text,
                        ),
                        booked: _booked,
                        price: double.parse(_priceController.text),
                        minLevel: _minLevel,
                        maxLevel: _maxLevel,
                        createdBy: userNotifier.value!.id,
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
        ),
      ),
    );
  }
}
