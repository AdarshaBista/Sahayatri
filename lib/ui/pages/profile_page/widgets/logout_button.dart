import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/ui/shared/dialogs/confirm_dialog.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20.0,
      onPressed: () => ConfirmDialog(
        message: 'Do you want to log out?',
        onConfirm: context.bloc<UserCubit>().logout,
      ).openDialog(context),
      icon: const Icon(
        Icons.login_outlined,
        size: 20.0,
      ),
    );
  }
}
