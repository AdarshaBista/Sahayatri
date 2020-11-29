import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:sahayatri/core/services/tracker_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/dialogs/confirm_dialog.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ConfirmDialog(
        message: 'Do you want to log out?',
        onConfirm: () async {
          context.openLoadingFlushBar(
            'Logging out...',
            isInteractive: false,
            callback: () async {
              context.read<TrackerService>().stop();
              await context.read<NearbyCubit>().stopNearby();
              await context.read<UserCubit>().logout();
            },
          );
        },
      ).openDialog(context),
      child: ScaleAnimator(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: context.c.background,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.exit_to_app,
            size: 18.0,
            color: AppColors.secondary,
          ),
        ),
      ),
    );
  }
}
