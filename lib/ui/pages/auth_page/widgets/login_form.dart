import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/pages/auth_page/widgets/auth_fields.dart';
import 'package:sahayatri/ui/pages/auth_page/widgets/auth_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500.0,
              ),
              child: CustomCard(
                margin: const EdgeInsets.all(24.0),
                padding: const EdgeInsets.all(24.0),
                color: AppColors.light.withOpacity(0.5),
                child: AuthFields(
                  initialEmail: email,
                  initialPassword: password,
                  onEmailChanged: (value) {},
                  onPasswordChanged: (value) {},
                ),
              ),
            ),
          ),
          AuthButton(
            label: 'LOGIN',
            icon: Icons.login_outlined,
            onPressed: () {
              if (!formKey.currentState.validate()) return;
            },
          ),
        ],
      ),
    );
  }
}
