import 'package:flutter/material.dart';

import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';
import 'package:sahayatri/ui/widgets/form/custom_text_field.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/pages/auth_page/widgets/auth_fields.dart';
import 'package:sahayatri/ui/pages/auth_page/widgets/auth_button.dart';

class SignUpForm extends StatefulWidget {
  final bool isInitial;

  const SignUpForm({
    @required this.isInitial,
  }) : assert(isInitial != null);

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
                  color: context.c.background,
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Username',
                        initialValue: username,
                        icon: AppIcons.username,
                        validator: FormValidators.requiredText(),
                        onChanged: (value) => username = value,
                      ),
                      const SizedBox(height: 20.0),
                      AuthFields(
                        initialEmail: email,
                        initialPassword: password,
                        onEmailChanged: (value) => email = value,
                        onPasswordChanged: (value) => password = value,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AuthButton(
              label: 'SIGN UP',
              formKey: formKey,
              isInitial: widget.isInitial,
              onPressed: () =>
                  context.read<UserCubit>().signUp(username, email, password),
            ),
          ],
        ),
      ),
    );
  }
}
