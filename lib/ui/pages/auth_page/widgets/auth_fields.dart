import 'package:flutter/material.dart';

import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/forms/custom_text_field.dart';

class AuthFields extends StatelessWidget {
  final String initialEmail;
  final String initialPassword;
  final void Function(String) onEmailChanged;
  final void Function(String) onPasswordChanged;

  const AuthFields({
    super.key,
    required this.initialEmail,
    required this.onEmailChanged,
    required this.initialPassword,
    required this.onPasswordChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: 'Email',
          initialValue: initialEmail,
          onChanged: onEmailChanged,
          icon: AppIcons.email,
          validator: FormValidators.email().call,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20.0),
        CustomTextField(
          label: 'Password',
          obscureText: true,
          icon: AppIcons.password,
          initialValue: initialPassword,
          onChanged: onPasswordChanged,
          validator: FormValidators.password().call,
        ),
      ],
    );
  }
}
