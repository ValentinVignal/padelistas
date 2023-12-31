import 'dart:async';

import 'package:animated_collection/animated_collection.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../services/auth.dart';
import '../../services/auth_user_notifier.dart';
import '../../utils/iterable_extension.dart';
import '../settings/settings_button.dart';

final _logger = Logger('VerifyEmailScreen');

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  var _error = '';
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        Auth.instance.currentUser!.reload();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify your email'),
        actions: const [
          PublicSettingsButton(),
        ],
      ),
      body: ListView(
        children: [
          AnimatedBuilder(
            animation: authUserNotifier,
            builder: (context, _) {
              return Center(
                child: Text(authUserNotifier.value?.email ?? ''),
              );
            },
          ),
          AnimatedVisibility(
            visible: _error.isNotEmpty,
            child: Text(
              _error,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Auth.instance.currentUser!.reload();
              },
              child: const Text('I have verified my email'),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () async {
                setState(() {
                  _error = '';
                });
                try {
                  await Auth.instance.currentUser!.sendEmailVerification();
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email sent'),
                    ),
                  );
                } catch (error, stackTrace) {
                  _logger.severe(
                    'Could not send the email verification',
                    error,
                    stackTrace,
                  );
                  setState(() {
                    _error = 'Unknown error';
                  });
                }
              },
              child: const Text('Resend email'),
            ),
          ),
        ].separated(const SizedBox(height: 8)).toList(),
      ),
    );
  }
}
