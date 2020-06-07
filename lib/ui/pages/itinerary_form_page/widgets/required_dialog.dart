import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
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
      duration: 200,
      child: AlertDialog(
        elevation: 12.0,
        clipBehavior: Clip.antiAlias,
        backgroundColor: AppColors.background,
        title: RequiredIndicator(message: message),
      ),
    );
  }
}
