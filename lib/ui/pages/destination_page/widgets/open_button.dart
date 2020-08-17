import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/auth_cubit/auth_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/dialogs/unauthenticated_dialog.dart';

class OpenButton extends StatelessWidget {
  const OpenButton();

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: CustomButton(
          label: 'OPEN',
          color: AppColors.dark,
          backgroundColor: AppColors.primary.withOpacity(0.3),
          iconData: Icons.keyboard_arrow_right,
          onTap: () {
            if (!context.bloc<AuthCubit>().isAuthenticated) {
              const UnauthenticatedDialog().openDialog(context);
              return;
            }

            context
                .repository<DestinationNavService>()
                .pushNamed(Routes.kDestinationDetailPageRoute);
          },
        ),
      ),
    );
  }
}
