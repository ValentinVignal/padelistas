import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:padelistas/router/routes.dart';
import 'package:padelistas/services/settings/user_notifier.dart';
import 'package:padelistas/utils/string.dart';

import '../../models/event_provider.dart';

class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});

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
          maxCrossAxisExtent: 250,
        ),
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(
                    label: Text(event.location.name.camelToTitle),
                  ),
                  const SizedBox(height: 16),
                  Flexible(
                    child: Builder(
                      builder: (context) {
                        return RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              const WidgetSpan(
                                child: Icon(Icons.calendar_today),
                              ),
                              const TextSpan(text: ' '),
                              TextSpan(
                                text: DateFormat.yMMMd().format(event.date),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Flexible(
                    child: Builder(
                      builder: (context) {
                        return RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              const WidgetSpan(
                                child: Icon(Icons.schedule),
                              ),
                              const TextSpan(text: ' '),
                              TextSpan(
                                text: DateFormat.jms().format(event.date),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: const _FAB(),
    );
  }
}

class _FAB extends ConsumerWidget {
  const _FAB();

  void _createEvent(BuildContext context) {
    if (userNotifier.isLoggedIn) {
      const EventCreateRoute().go(context);
    } else {
      LoginRoute(
        redirectUrl: Uri.parse(const EventCreateRoute().location),
      ).push(context);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        _createEvent(context);
      },
      child: const Icon(Icons.add),
    );
  }
}
