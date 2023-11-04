import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';
import '../../services/auth_user_notifier.dart';
import '../../services/user_notifier.dart';
import '../../utils/bool.dart';
import '../../utils/iterable_extension.dart';
import '../../widgets/phone_number_form_field.dart';

class MyAccountBody extends ConsumerStatefulWidget {
  const MyAccountBody({
    required this.isSetUp,
    super.key,
  });

  final bool isSetUp;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAccountBodyState();
}

class _MyAccountBodyState extends ConsumerState<MyAccountBody> {
  late User user;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController(text: '+65');

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

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final authUser = authUserNotifier.value!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(authUser.uid)
        .set(user.toJson());

    final method = authUser.providerData
        .map(
          (data) => data.providerId,
        )
        .join(', ');
    if (widget.isSetUp) {
      FirebaseAnalytics.instance.logSignUp(signUpMethod: method);
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Saved'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(loggedInUserProvider).value;
    ref.listen(loggedInUserProvider, (previous, next) {
      final previousUser = previous?.value.value;
      final nextUser = next.value.value;
      if (nextUser != null && nextUser != previousUser) {
        _firstNameController.text = nextUser.firstName;
        _lastNameController.text = nextUser.lastName;
        _phoneNumberController.text = nextUser.phoneNumber;
      }
    });
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(32),
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(label: Text('* First name')),
            controller: _firstNameController,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Mandatory field';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(label: Text('* Last name')),
            controller: _lastNameController,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Mandatory field';
              }
              return null;
            },
          ),
          PhoneNumberFormField(
            phoneNumberController: _phoneNumberController,
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: (user.hasValue).nullIfFalse(_save),
              child: const Text('Save'),
            ),
          ),
        ].separated(const SizedBox(height: 16)).toList(),
      ),
    );
  }
}
