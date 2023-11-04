import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';
import '../../models/users_provider.dart';
import '../../widgets/bottom_navigation.dart';

enum _UserOption {
  approve,
  disapprove,
}

class UsersScreen extends ConsumerWidget {
  const UsersScreen({super.key});

  Future<void> _onSelected(
      BuildContext context, User user, _UserOption option) async {
    switch (option) {
      case _UserOption.approve:
        FirebaseFirestore.instance.collection('users').doc(user.id).update({
          'isApproved': true,
        });
        break;
      case _UserOption.disapprove:
        FirebaseFirestore.instance.collection('users').doc(user.id).update({
          'isApproved': false,
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersProvider).valueOrNull ?? const [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final theme = Theme.of(context);
          final user = users[index];
          final IconData icon;
          final Color color;
          switch (user.isApproved) {
            case null:
              icon = Icons.question_mark;
              color = theme.colorScheme.error;
            case false:
              icon = Icons.close;
              color = theme.colorScheme.error;
            case true:
              icon = Icons.check;
              color = theme.colorScheme.secondary;
          }
          return ListTile(
            leading: Icon(
              icon,
              color: color,
            ),
            title: Row(
              children: [
                if (user.isAdmin) const Icon(Icons.admin_panel_settings),
                Flexible(
                  child: SelectableText(user.fullName),
                ),
              ],
            ),
            subtitle: SelectableText(user.phoneNumber),
            trailing: PopupMenuButton(
              onSelected: (value) => _onSelected(context, user, value),
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: _UserOption.approve,
                  child: ListTile(
                    leading: Icon(Icons.check),
                    title: Text('Approve'),
                  ),
                ),
                PopupMenuItem(
                  value: _UserOption.disapprove,
                  child: ListTile(
                    leading: Icon(Icons.close),
                    title: Text('Disapprove'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
