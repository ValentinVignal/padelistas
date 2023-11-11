import 'package:animated_collection/animated_collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../utils/iterable_extension.dart';
import '../settings/settings_button.dart';

final _logger = Logger('ResetPasswordScreen');

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  String? _error;

  Future<void> _sendEmail() async {
    setState(() {
      _error = null;
    });

    if (!_formKey.currentState!.validate()) return;

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent'),
        ),
      );
    } on FirebaseAuthException catch (error, stackTrace) {
      setState(() {
        switch (error.code) {
          case 'invalid-email':
            _error = 'Invalid email';
            break;
          default:
            _logger.severe(
                'Could not send password reset email', error, stackTrace);
            _error = 'Unknown error';
            break;
        }
      });
    } catch (error, stackTrace) {
      _logger.severe('Could not send password reset email', error, stackTrace);
      setState(() {
        _error = 'Unknown error';
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        actions: const [PublicSettingsButton()],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required ';
                  }
                  return null;
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: _sendEmail,
                child: const Text('Send reset password email'),
              ),
            ),
            AnimatedVisibility(
              visible: _error?.isNotEmpty ?? false,
              child: Text(
                _error ?? '',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ].separated(const SizedBox(height: 16)).toList(),
        ),
      ),
    );
  }
}
