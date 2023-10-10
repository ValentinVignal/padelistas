import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/users_provider.dart';

class UsersScreen extends ConsumerWidget {
  const UsersScreen({super.key});

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
          return ListTile(
            leading: Icon(
              user.isApproved ? Icons.check : Icons.question_mark,
              color: user.isApproved
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.error,
            ),
            title: Row(
              children: [
                if (user.isAdmin) const Icon(Icons.admin_panel_settings),
                Flexible(
                  child: SelectableText('${user.firstName} ${user.lastName}'),
                ),
              ],
            ),
            subtitle: SelectableText(user.phoneNumber),
            trailing: PopupMenuButton(itemBuilder: (context) => const []),
          );
        },
      ),
    );
  }
}
