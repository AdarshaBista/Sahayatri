import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/auth_cubit/auth_cubit.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:sahayatri/ui/styles/styles.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: (state is AuthLoading) ? null : context.bloc<AuthCubit>().logout,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: (state is AuthLoading)
                ? SizedBox(
                    width: 32.0,
                    height: 32.0,
                    child: LoadingIndicator(
                      color: AppColors.primary,
                      indicatorType: Indicator.ballSpinFadeLoader,
                    ),
                  )
                : Text(
                    'LOGOUT',
                    style: AppTextStyles.small.light,
                  ),
          ),
        );
      },
    );
  }
}
