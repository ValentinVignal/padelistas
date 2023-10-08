import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/auth.dart';
import '../../services/auth_user_notifier.dart';
import '../../widgets/theme_switch.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(loggedInAuthUserProvider).isLoggedIn;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Text('Theme'),
                ),
                ThemeSwitch()
              ],
            ),
          ),
          if (isLoggedIn) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Divider(),
            ),
            Center(
              child: OutlinedButton.icon(
                onPressed: () {
                  Auth.instance.signOut();
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
