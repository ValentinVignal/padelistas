import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    this.redirect,
    super.key,
  });

  final Uri? redirect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () async {
          await FirebaseAuth.instance.signInAnonymously();
          if (!context.mounted) return;
          if (redirect != null) {
            GoRouter.of(context).pushReplacement(redirect!.toString());
          } else {
            Navigator.of(context).pop();
          }
        },
        child: const Text('Login'),
      ),
    );
  }
}
