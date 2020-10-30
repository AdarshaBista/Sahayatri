import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/indicators/simple_busy_indicator.dart';

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
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is AuthError) {
          context.openFlushBar(state.message, type: FlushbarType.error);
        }
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
}
