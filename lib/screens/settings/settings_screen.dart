import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../router/routes.dart';
import '../../services/auth.dart';
import '../../services/auth_user_notifier.dart';
import '../../services/info_plus.dart';
import '../../utils/bool.dart';
import '../../widgets/beta_widget.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/theme_switch.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({
    required this.public,
    super.key,
  });

  final bool public;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(loggedInAuthUserProvider).isLoggedIn;
    return Scaffold(
      appBar: AppBar(
        leading: (public && !Navigator.of(context).canPop()).nullIfFalse(
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
          if (!public && isLoggedIn)
            BetaWidget(
              child: ListTile(
                leading: const Icon(Icons.person),
                onTap: () => const MyAccountRoute().go(context),
                title: const Text('My account'),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          const ListTile(
            leading: Icon(Icons.contrast),
            title: Text('Theme'),
            trailing: ThemeSwitch(),
          ),
          AboutListTile(
            icon: const Icon(Icons.info),
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
      bottomNavigationBar: (!public).nullIfFalse(const BottomNavigation()),
    );
  }
}
