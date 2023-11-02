import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../router/routes.dart';
import '../../services/info_plus.dart';
import '../../utils/bool.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        title: const Text('About'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Version'),
            subtitle: Text(
              ref.watch(infoPlusProvider).valueOrNull?.version ?? '',
            ),
          ),
        ],
      ),
    );
  }
}
