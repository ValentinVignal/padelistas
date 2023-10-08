import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/user.dart';
import '../../services/auth_user_notifier.dart';
import '../../utils/iterable_extension.dart';
import '../settings/settings_button.dart';

class SetUpProfileScreen extends StatefulWidget {
  const SetUpProfileScreen({super.key});

  @override
  State<SetUpProfileScreen> createState() => _SetUpProfileScreenState();
}

class _SetUpProfileScreenState extends State<SetUpProfileScreen> {
  late User user;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    user = const User(
      id: '',
      firstName: '',
      lastName: '',
      phoneNumber: '',
    );
    _firstNameController.addListener(() {
      setState(() {
        user = user.copyWith(firstName: _firstNameController.text);
      });
    });
    _lastNameController.addListener(() {
      setState(() {
        user = user.copyWith(lastName: _lastNameController.text);
      });
    });
    _phoneNumberController.addListener(() {
      setState(() {
        user = user.copyWith(phoneNumber: _phoneNumberController.text);
      });
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(authUserNotifier.value!.uid)
        .set(user.toJson());
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Submitted'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Up Profile'),
        actions: const [SettingsButton()],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(32),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(label: Text('First name')),
              controller: _firstNameController,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Mandatory field';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(label: Text('Last name')),
              controller: _lastNameController,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Mandatory field';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(label: Text('Phone number')),
              controller: _phoneNumberController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'(\+|[0-9])')),
              ],
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Mandatory field';
                }
                if (!_phoneNumberRegExp.hasMatch(value!)) {
                  return 'Phone number not valid';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('Submit'),
              ),
            ),
          ].separated(const SizedBox(height: 16)).toList(),
        ),
      ),
    );
  }
}

final _phoneNumberRegExp = RegExp(r'^\+?[0-9]{6,15}$');
