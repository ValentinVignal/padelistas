import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../router/routes.dart';
import '../../services/auth.dart';
import '../../services/auth_user_notifier.dart';
import '../../services/info_plus.dart';
import '../../utils/bool.dart';
import '../../widgets/theme_switch.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(loggedInAuthUserProvider).isLoggedIn;
    return Scaffold(
      appBar: AppBar(
        leading: (!Navigator.of(context).canPop()).nullIfFalse(
          IconButton(
            onPressed: () {
              const HomeRoute().go(context);
            },
            icon: const Icon(Icons.home),
          ),
        ),
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
          AboutListTile(
            applicationVersion:
                ref.watch(infoPlusProvider).valueOrNull?.version ?? '',
          ),
          if (isLoggedIn) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Divider(),
            ),
            Center(
              child: OutlinedButton.icon(
                onPressed: () {
                  FirebaseFirestore.instance.waitForPendingWrites();
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
