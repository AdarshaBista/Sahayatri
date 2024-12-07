import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/pages/auth_page/widgets/auth_button.dart';
import 'package:sahayatri/ui/pages/auth_page/widgets/auth_fields.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';

class LoginForm extends StatefulWidget {
  final bool isInitial;

  const LoginForm({
    super.key,
    required this.isInitial,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return SlideAnimator(
      begin: const Offset(0.0, 0.5),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500.0),
                child: CustomCard(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(20.0),
                  color: context.c.surface,
                  child: AuthFields(
                    initialEmail: email,
                    initialPassword: password,
                    onEmailChanged: (value) => email = value,
                    onPasswordChanged: (value) => password = value,
                  ),
                ),
              ),
            ),
            AuthButton(
              label: 'LOGIN',
              formKey: formKey,
              isInitial: widget.isInitial,
              onPressed: () => context.read<UserCubit>().login(email, password),
            ),
          ],
        ),
      ),
    );
  }
}
