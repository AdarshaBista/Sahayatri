import 'package:flutter/material.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';
import 'package:sahayatri/ui/shared/indicators/unauthenticated_indicator.dart';

class UnauthenticatedView extends StatelessWidget {
  const UnauthenticatedView();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const UnauthenticatedIndicator(),
        CustomButton(
          label: 'Login / Sign Up',
          outlineOnly: true,
          iconData: Icons.account_box,
          color: AppColors.dark,
          onTap: () => context
              .repository<RootNavService>()
              .pushNamed(Routes.kAuthPageRoute, arguments: false),
        )
      ],
    );
  }
}
