import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/extensions/dialog_extension.dart';
import 'package:sahayatri/core/extensions/flushbar_extension.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/circular_button.dart';
import 'package:sahayatri/ui/widgets/dialogs/confirm_dialog.dart';

import 'package:sahayatri/locator.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  @override
  Widget build(BuildContext context) {
    return CircularButton(
      color: AppColors.secondary,
      icon: AppIcons.logout,
      backgroundColor: context.c.surface,
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
        if (!success && context.mounted) {
          context.openFlushBar('Could not logout!', type: FlushbarType.error);
          return;
        }
        locator<RootNavService>().pushOnly(Routes.authPageRoute);
      },
    );
  }
}
