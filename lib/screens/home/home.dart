import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padelistas/router/routes.dart';

import '../../services/settings/user_notifier.dart';

enum _HomeOptions {
  settings,
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(loggedInUserProvider).isLoggedIn;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Padelistas'),
        actions: [
          if (!isLoggedIn) ...[
            OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Coming soon...'),
                  ),
                );
              },
              child: const Text('Login'),
            ),
            const SizedBox(width: 8),
          ],
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case _HomeOptions.settings:
                  const SettingsRoute().go(context);
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: _HomeOptions.settings,
                  child: ListTile(
                    leading: Icon(
                      Icons.settings,
                    ),
                    title: Text('Settings'),
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Coming soon...'),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                  onPressed: () {
                    const UsersRoute().go(context);
                  },
                  child: const Text('Users'),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () {
                    const EventsRoute().go(context);
                  },
                  child: const Text('Events'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
