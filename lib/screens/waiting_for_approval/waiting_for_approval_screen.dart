import 'package:flutter/material.dart';

import '../settings/settings_button.dart';

class WaitingForApprovalScreen extends StatelessWidget {
  const WaitingForApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waiting for approval'),
        actions: const [SettingsButton()],
      ),
    );
  }
}
