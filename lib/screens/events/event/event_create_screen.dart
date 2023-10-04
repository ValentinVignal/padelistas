import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:padelistas/models/location.dart';
import 'package:padelistas/utils/bool.dart';

import '../../../models/event.dart';

class EventCreateScreen extends StatefulWidget {
  const EventCreateScreen({super.key});

  @override
  State<EventCreateScreen> createState() => _EventCreateScreenState();
}

class _EventCreateScreenState extends State<EventCreateScreen> {
  Location? location;

  DateTime? date;

  TimeOfDay? time;

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
    }
    if (!mounted) return;
    await _pickTime(context);
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                      child: Text(location.name),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
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
          const SizedBox(height: 32),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _canSave().nullIfFalse(() async {
                  await FirebaseFirestore.instance.collection('events').add(
                        Event(
                          date: date!.add(
                            Duration(hours: time!.hour, minutes: time!.minute),
                          ),
                          location: location!,
                        ).toJson(),
                      );
                  if (!mounted) return;

                  Navigator.of(context).pop();
                }),
                child: const Text('Create'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
