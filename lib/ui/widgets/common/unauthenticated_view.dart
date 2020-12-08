import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/indicators/unauthenticated_indicator.dart';

class UnauthenticatedView extends StatelessWidget {
  const UnauthenticatedView();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      const UnauthenticatedIndicator(),
      CustomButton(
        label: 'Login / Sign Up',
        expanded: false,
        icon: Icons.login_outlined,
        color: AppColors.primaryDark,
        backgroundColor: Colors.transparent,
        onTap: () {
          locator<RootNavService>().pushNamed(Routes.authPageRoute, arguments: false);
        },
      ),
    ]);
  }
}
