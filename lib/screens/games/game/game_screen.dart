import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../models/game.dart';
import '../../../models/game_provider.dart';
import '../../../models/level.dart';
import '../../../models/location.dart';
import '../../../services/user_notifier.dart';
import '../../../utils/bool.dart';
import '../../../utils/duration.dart';
import '../../../utils/iterable_extension.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({
    required this.id,
    super.key,
  });

  final String? id;

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  Location? _location;

  DateTime? _date;

  TimeOfDay? _time;

  var _duration = const Duration(hours: 1, minutes: 30);

  final _numberOfPlayersController = TextEditingController(text: '4');
  final _waitListController = TextEditingController(text: '2');

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
      if (_time != null) return;
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
  void initState() {
    super.initState();
    if (widget.id != null) {
      ref.listenManual(
        gameProvider(widget.id!),
        (previous, next) {
          if (next.valueOrNull != null &&
              previous?.valueOrNull != next.valueOrNull) {
            _onNewData(next.value!);
          }
        },
        fireImmediately: true,
      );
    }
  }

  @override
  void dispose() {
    _numberOfPlayersController.dispose();
    _waitListController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _onNewData(Game game) {
    setState(() {
      _location = game.location;
      _date = game.date;
      _time = TimeOfDay.fromDateTime(game.date);
      _duration = game.duration;
      _numberOfPlayersController.text = game.numberOfPlayers.toString();
      _waitListController.text = game.numberOfWaitListPlayers.toString();
      _booked = game.booked;
      _priceController.text = game.price.toString();
      _minLevel = game.minLevel;
      _maxLevel = game.maxLevel;
    });
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;
    if (widget.id == null) {
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
        createdBy: userNotifier.user!.id,
        numberOfWaitListPlayers: int.parse(_waitListController.text),
      );
      await FirebaseFirestore.instance.collection('games').add(
            game.toJson(),
          );
      FirebaseAnalytics.instance.logEvent(
        name: 'game_new',
        parameters: game.toSimpleJson(),
      );
    } else {
      final game = (await ref.read(gameProvider(widget.id!).future)).copyWith(
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
        createdBy: userNotifier.user!.id,
        numberOfWaitListPlayers: int.parse(_waitListController.text),
      );
      await FirebaseFirestore.instance
          .collection('games')
          .doc(widget.id!)
          .update(
            game.toJson(),
          );
      FirebaseAnalytics.instance.logEvent(
        name: 'game_edit',
        parameters: game.toSimpleJson(),
      );
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved')),
    );

    Navigator.of(context).pop();
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
                          if (_date == null) {
                            _pickDate(context);
                          }
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
                    flex: 2,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('* Wait list'),
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
                      controller: _waitListController,
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
                      decoration: const InputDecoration(label: Text('* Price')),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]|\.')),
                      ],
                      validator: (value) {
                        if (value?.isEmpty ?? true) return 'Required';
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
                children: [
                  if (widget.id != null)
                    OutlinedButton.icon(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('games')
                            .doc(widget.id!)
                            .delete();
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Deleted')),
                        );

                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.error,
                        ),
                      ),
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                    ),
                  const Spacer(),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _canSave().nullIfFalse(_onSave),
                    icon: const Icon(Icons.check),
                    label: const Text('Save'),
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
