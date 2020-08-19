import 'package:flutter/material.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/pages/auth_page/widgets/auth_fields.dart';
import 'package:sahayatri/ui/pages/auth_page/widgets/auth_button.dart';

class LoginForm extends StatefulWidget {
  final bool isInitial;

  const LoginForm({
    @required this.isInitial,
  }) : assert(isInitial != null);

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
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(20.0),
                color: AppColors.light.withOpacity(0.4),
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
            icon: Icons.login_outlined,
            onPressed: () async {
              if (!formKey.currentState.validate()) return;

              final success = await context.bloc<UserCubit>().login(email, password);
              if (success) {
                if (widget.isInitial) {
                  context
                      .repository<RootNavService>()
                      .pushReplacementNamed(Routes.kHomePageRoute);
                } else {
                  Navigator.of(context).pop();
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
