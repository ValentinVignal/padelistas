import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/auth_user_notifier.dart';
import '../../services/user_notifier.dart';
import '../../utils/iterable_extension.dart';
import '../../widgets/phone_number_form_field.dart';
import '../settings/settings_button.dart';

class WaitingForApprovalScreen extends ConsumerStatefulWidget {
  const WaitingForApprovalScreen({super.key});

  @override
  ConsumerState<WaitingForApprovalScreen> createState() =>
      _WaitingForApprovalScreenState();
}

class _WaitingForApprovalScreenState
    extends ConsumerState<WaitingForApprovalScreen> {
  final _phoneNumberController = TextEditingController(text: '+65');

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(authUserNotifier.value!.uid)
        .update({'phoneNumber': _phoneNumberController.text});
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Submitted'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(loggedInUserProvider);
    final phoneNumber = user.value?.phoneNumber;
    final String phoneNumberText;
    if (phoneNumber == null) {
      phoneNumberText = '';
    } else {
      phoneNumberText = ' ($phoneNumber)';
    }

    ref.listen(loggedInUserProvider, (previous, next) {
      if (previous?.value?.phoneNumber != next.value?.phoneNumber) {
        _phoneNumberController.text = next.value?.phoneNumber ?? '';
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Waiting for approval'),
        actions: const [SettingsButton()],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          children: [
            const SizedBox(height: 16),
            Center(
              child: Text(
                'An admin will contact you$phoneNumberText soon to approve your account.',
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),
            const Center(
              child: Text('Change your number:'),
            ),
            PhoneNumberFormField(phoneNumberController: _phoneNumberController),
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
