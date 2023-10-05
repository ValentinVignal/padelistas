import 'package:flutter/material.dart';
import 'package:padelistas/router/routes.dart';

enum _HomeOptions {
  settings,
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Padelistas'),
        actions: [
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
