import 'package:flutter/material.dart';

import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/widgets/form/custom_text_field.dart';
import 'package:sahayatri/ui/pages/auth_page/widgets/auth_fields.dart';
import 'package:sahayatri/ui/pages/auth_page/widgets/auth_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm();

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomCard(
            margin: const EdgeInsets.all(24.0),
            padding: const EdgeInsets.all(24.0),
            color: AppColors.light.withOpacity(0.5),
            child: Column(
              children: [
                CustomTextField(
                  label: 'Username',
                  iconGap: 10.0,
                  color: AppColors.light,
                  initialValue: username,
                  icon: Icons.account_circle_outlined,
                  validator: FormValidators.requiredText(),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20.0),
                AuthFields(
                  initialEmail: email,
                  initialPassword: password,
                  onEmailChanged: (value) {},
                  onPasswordChanged: (value) {},
                ),
              ],
            ),
          ),
          AuthButton(
            label: 'SIGN UP',
            icon: Icons.app_registration,
            onPressed: () {
              if (!formKey.currentState.validate()) return;
            },
          ),
        ],
      ),
    );
  }
}
