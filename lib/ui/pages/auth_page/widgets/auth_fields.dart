import 'package:flutter/material.dart';

import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/widgets/form/custom_text_field.dart';

class AuthFields extends StatelessWidget {
  final String initialEmail;
  final String initialPassword;
  final void Function(String) onEmailChanged;
  final void Function(String) onPasswordChanged;

  const AuthFields({
    @required this.initialEmail,
    @required this.onEmailChanged,
    @required this.initialPassword,
    @required this.onPasswordChanged,
  })  : assert(initialEmail != null),
        assert(onEmailChanged != null),
        assert(initialPassword != null),
        assert(onPasswordChanged != null);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: const EdgeInsets.all(24.0),
      padding: const EdgeInsets.all(24.0),
      color: AppColors.light.withOpacity(0.5),
      child: Column(
        children: [
          CustomTextField(
            label: 'Email',
            iconGap: 10.0,
            color: AppColors.light,
            initialValue: initialEmail,
            onChanged: onEmailChanged,
            icon: Icons.email_outlined,
            validator: FormValidators.email(),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20.0),
          CustomTextField(
            label: 'Password',
            iconGap: 10.0,
            obscureText: true,
            color: AppColors.light,
            icon: Icons.lock_outline,
            initialValue: initialPassword,
            onChanged: onPasswordChanged,
            validator: FormValidators.password(),
          ),
        ],
      ),
    );
  }
}
