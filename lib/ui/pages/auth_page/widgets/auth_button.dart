import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/auth_cubit/auth_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/indicators/simple_busy_indicator.dart';

class AuthButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const AuthButton({
    @required this.label,
    @required this.icon,
    @required this.onPressed,
  })  : assert(label != null),
        assert(icon != null),
        assert(onPressed != null);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) _showSnackBar(context, state.message);
      },
      builder: (context, state) {
        return FloatingActionButton.extended(
          heroTag: '$label Tag',
          icon: Icon(icon),
          onPressed: (state is AuthLoading) ? null : onPressed,
          label: (state is AuthLoading)
              ? const SimpleBusyIndicator()
              : Text(
                  label,
                  style: AppTextStyles.small.bold.primary,
                ),
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: AppTextStyles.small.light,
          ),
        ),
      );
  }
}
