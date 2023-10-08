import 'package:flutter/material.dart';

import '../../router/routes.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        const SettingsRoute().push(context);
      },
    );
  }
}
