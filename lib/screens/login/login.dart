import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () async {
          await FirebaseAuth.instance.signInAnonymously();
          if (!context.mounted) return;
          Navigator.of(context).pop();
        },
        child: const Text('Login'),
      ),
    );
  }
}
