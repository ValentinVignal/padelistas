import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/settings/user_notifier.dart';

enum _HomeOptions {
  settings,
  logInOrOut,
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
              onPressed: () {},
              child: const Text('Login'),
            ),
            const SizedBox(width: 8),
          ],
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case _HomeOptions.settings:
                  break;
                case _HomeOptions.logInOrOut:
                  if (isLoggedIn) {
                    FirebaseAuth.instance.signOut();
                  } else {}
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: _HomeOptions.logInOrOut,
                  child: Consumer(
                    builder: (context, ref, _) {
                      final isLoggedIn =
                          ref.watch(loggedInUserProvider).isLoggedIn;
                      return ListTile(
                        leading: Icon(
                          isLoggedIn ? Icons.logout : Icons.login,
                        ),
                        title: Text(isLoggedIn ? 'Logout' : 'Login'),
                      );
                    },
                  ),
                ),
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
                  onPressed: () {},
                  child: const Text('Users'),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () {},
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
