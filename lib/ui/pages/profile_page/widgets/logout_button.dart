import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/auth_cubit/auth_cubit.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20.0,
      onPressed: context.bloc<AuthCubit>().logout,
      icon: const Icon(
        Icons.login_outlined,
        size: 20.0,
      ),
    );
  }
}
