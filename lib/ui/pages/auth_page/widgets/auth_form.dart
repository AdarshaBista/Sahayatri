import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/pages/auth_page/widgets/auth_fields.dart';

class AuthForm extends StatefulWidget {
  final String buttonLabel;
  final IconData buttonIcon;
  final VoidCallback onSubmit;

  const AuthForm({
    @required this.onSubmit,
    @required this.buttonIcon,
    @required this.buttonLabel,
  })  : assert(onSubmit != null),
        assert(buttonIcon != null),
        assert(buttonLabel != null);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: formKey,
          child: AuthFields(
            initialEmail: email,
            initialPassword: password,
            onEmailChanged: (value) {},
            onPasswordChanged: (value) {},
          ),
        ),
        FloatingActionButton.extended(
          label: Text(
            widget.buttonLabel,
            style: AppTextStyles.small.bold.primary,
          ),
          icon: Icon(widget.buttonIcon),
          onPressed: () {
            if (!formKey.currentState.validate()) return;
            widget.onSubmit();
          },
        ),
      ],
    );
  }
}
