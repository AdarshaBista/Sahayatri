import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';

class OpenButton extends StatelessWidget {
  const OpenButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return _buildButton(context);
        }
        return const Offstage();
      },
    );
  }

  Widget _buildButton(BuildContext context) {
    return FadeAnimator(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 12.0),
        child: CustomButton(
          label: 'OPEN',
          icon: Icons.keyboard_arrow_right,
          onTap: () {
            locator<DestinationNavService>().pushNamed(Routes.destinationDetailPageRoute);
          },
        ),
      ),
    );
  }
}
