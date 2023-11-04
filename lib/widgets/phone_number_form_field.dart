import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberFormField extends StatelessWidget {
  const PhoneNumberFormField({
    super.key,
    required TextEditingController phoneNumberController,
  }) : _phoneNumberController = phoneNumberController;

  final TextEditingController _phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(label: Text('* Phone number')),
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
    );
  }
}

final _phoneNumberRegExp = RegExp(r'^\+?[0-9]{6,15}$');
