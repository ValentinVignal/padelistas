import 'package:flutter/material.dart';

import '../../widgets/bottom_navigation.dart';
import 'my_account_body.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: const MyAccountBody(isSetUp: false),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
