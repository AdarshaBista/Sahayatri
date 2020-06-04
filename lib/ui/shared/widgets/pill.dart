import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class Pill extends StatelessWidget {
  const Pill();

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      child: Container(
        margin: const EdgeInsets.all(6.0),
        height: 5.0,
        width: 32.0,
        decoration: BoxDecoration(
          color: AppColors.dark.withOpacity(0.4),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
