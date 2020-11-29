import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/dialogs/custom_dialog.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/common/unauthenticated_view.dart';

class OpenButton extends StatelessWidget {
  const OpenButton();

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: CustomButton(
          label: 'OPEN',
          icon: Icons.keyboard_arrow_right,
          onTap: () {
            if (!context.read<UserCubit>().isAuthenticated) {
              CustomDialog(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: UnauthenticatedView(
                  onLogin: () => Navigator.of(context).pop(),
                ),
              ).openDialog(context);
              return;
            }

            context
                .read<DestinationNavService>()
                .pushNamed(Routes.destinationDetailPageRoute);
          },
        ),
      ),
    );
  }
}
