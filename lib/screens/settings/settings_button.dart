import 'package:flutter/material.dart';

import '../../router/routes.dart';

class PublicSettingsButton extends StatelessWidget {
  const PublicSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        const PublicSettingsRoute().push(context);
      },
    );
  }
}
