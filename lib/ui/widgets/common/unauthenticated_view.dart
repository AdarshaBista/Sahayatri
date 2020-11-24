import 'package:flutter/material.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/indicators/unauthenticated_indicator.dart';

class UnauthenticatedView extends StatelessWidget {
  final VoidCallback onLogin;

  const UnauthenticatedView({
    this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const UnauthenticatedIndicator(),
        CustomButton(
          label: 'Login / Sign Up',
          outline: true,
          icon: Icons.account_box,
          color: context.c.onBackground,
          onTap: () {
            if (onLogin != null) onLogin();

            context
                .read<RootNavService>()
                .pushNamed(Routes.authPageRoute, arguments: false);
          },
        ),
      ],
    );
  }
}
