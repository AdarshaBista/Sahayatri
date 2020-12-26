import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/extensions/index.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

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
        onConfirm: () => _logout(context),
      ).openDialog(context),
    );
  }

  Future<void> _logout(BuildContext context) async {
    context.openLoadingFlushBar(
      'Logging out...',
      isInteractive: false,
      callback: () async {
        final success = await context.read<UserCubit>().logout();
        if (!success) {
          context.openFlushBar('Could not logout!', type: FlushbarType.error);
          return;
        }
        locator<RootNavService>().pushOnly(Routes.authPageRoute);
      },
    );
  }
}
