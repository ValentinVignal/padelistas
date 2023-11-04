import 'package:animated_collection/animated_collection.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../../router/routes.dart';
import '../../services/auth.dart';
import '../../utils/iterable_extension.dart';
import '../settings/settings_button.dart';
import 'google_sign_in.dart';

final _logger = Logger('LoginScreen');

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: const [PublicSettingsButton()],
      ),
      body: const _LoginScreenContent(),
    );
  }
}

class _LoginScreenContent extends StatefulWidget {
  const _LoginScreenContent();

  @override
  State<_LoginScreenContent> createState() => __LoginScreenContentState();
}

class __LoginScreenContentState extends State<_LoginScreenContent> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _obscure = true;
  final _formKey = GlobalKey<FormState>();
  var _error = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _error = '';
    });
    if (!_formKey.currentState!.validate()) return;
    try {
      await Auth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      await FirebaseAnalytics.instance.logLogin(loginMethod: 'email');
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'invalid-login-credentials':
            _error = 'Invalid login credentials';
            break;
          default:
            _error = e.message ?? 'Unknown error';
            break;
        }
      });
    } catch (error, stackTrace) {
      _logger.severe(
        'Could not login',
        error,
        stackTrace,
      );
      setState(() {
        _error = 'Unknown error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              decoration: const InputDecoration(label: Text('Email')),
              controller: _emailController,
              validator: (value) =>
                  (value?.isNotEmpty ?? false) ? null : 'Required',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              decoration: InputDecoration(
                label: const Text('Password'),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscure = !_obscure;
                    });
                  },
                  icon: Icon(
                    _obscure ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              controller: _passwordController,
              obscureText: _obscure,
              onFieldSubmitted: (_) => _login(),
              validator: (value) =>
                  (value?.isNotEmpty ?? false) ? null : 'Required',
            ),
          ),
          AnimatedVisibility(
            visible: _error.isNotEmpty,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  _error,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ),
          ),
          const Center(
            child: GoogleSignInWidget(),
          ),
          Center(
            child: ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: () {
                GoRouter.of(context).go(const SignUpRoute().location);
              },
              child: const Text('Sign Up'),
            ),
          ),
        ].separated(const SizedBox(height: 8)).toList(),
      ),
    );
  }
}
