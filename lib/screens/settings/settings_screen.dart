import 'package:flutter/material.dart';
import 'package:padelistas/widgets/theme_switch.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Text('Theme'),
                ),
                ThemeSwitch()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
