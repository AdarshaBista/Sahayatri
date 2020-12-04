import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:sahayatri/core/services/tracker_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/dialogs/confirm_dialog.dart';
import 'package:sahayatri/ui/widgets/buttons/circular_button.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton();

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      color: AppColors.secondary,
      icon: Icons.exit_to_app_outlined,
      backgroundColor: context.c.background,
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
    );
  }
}
