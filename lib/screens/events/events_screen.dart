import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:padelistas/router/routes.dart';

import '../../models/event_provider.dart';

class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});

  void _createEvent(BuildContext context) {
    const EventCreateRoute().go(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventsProvider).valueOrNull ?? const [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: GridView.builder(
        itemCount: events.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
        ),
        itemBuilder: (context, index) {
          final event = events[index];
          final date = DateFormat.yMd().add_jms().format(event.date);
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Location: ${event.location.name}',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Date: $date',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createEvent(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
