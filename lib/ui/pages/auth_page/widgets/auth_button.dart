import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';
import 'package:sahayatri/core/extensions/flushbar_extension.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/indicators/circular_busy_indicator.dart';

class AuthButton extends StatelessWidget {
  final String label;
  final bool isInitial;
  final GlobalKey<FormState> formKey;
  final Future<bool> Function() onPressed;

  const AuthButton({
    @required this.label,
    @required this.formKey,
    @required this.isInitial,
    @required this.onPressed,
  })  : assert(label != null),
        assert(formKey != null),
        assert(isInitial != null),
        assert(onPressed != null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return FloatingActionButton.extended(
          heroTag: '$label Tag',
          backgroundColor: AppColors.dark,
          onPressed: (state is AuthLoading) ? null : () async => _authenticate(context),
          label: (state is AuthLoading)
              ? const CircularBusyIndicator()
              : Text(
                  label,
                  style: AppTextStyles.headline5.bold.primary,
                ),
        );
      },
    );
  }

  Future<void> _authenticate(BuildContext context) async {
    if (!formKey.currentState.validate()) return;

    final success = await onPressed();
    if (!success) {
      context.openFlushBar('An error has occured!', type: FlushbarType.error);
      return;
    }

    if (isInitial) {
      locator<RootNavService>().pushOnly(Routes.homePageRoute);
    } else {
      Navigator.of(context).pop();
    }
  }
}
