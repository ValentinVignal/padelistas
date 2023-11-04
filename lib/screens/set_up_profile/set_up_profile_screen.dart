import 'package:flutter/material.dart';

import '../my_account/my_account_body.dart';
import '../settings/settings_button.dart';

class SetUProfileScreen extends StatelessWidget {
  const SetUProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set up your profile'),
        actions: const [
          PublicSettingsButton(),
        ],
      ),
      body: const MyAccountBody(isSetUp: true),
    );
  }
}
