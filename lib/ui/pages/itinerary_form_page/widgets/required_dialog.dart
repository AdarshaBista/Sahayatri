import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';
import 'package:sahayatri/ui/shared/indicators/required_indicator.dart';

class RequiredDialog extends StatelessWidget {
  final String message;

  const RequiredDialog({
    this.message = 'Please fill in the given fields.',
  }) : assert(message != null);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      duration: 300,
      child: CustomCard(
        elevation: 12.0,
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.2,
          vertical: MediaQuery.of(context).size.height * 0.3,
        ),
        color: AppColors.background,
        child: RequiredIndicator(message: message),
      ),
    );
  }
}
