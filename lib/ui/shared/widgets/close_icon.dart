import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class CloseIcon extends StatelessWidget {
  final IconData iconData;

  const CloseIcon({
    this.iconData = Icons.close,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: ScaleAnimator(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppColors.dark,
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconData,
            color: AppColors.background,
          ),
        ),
      ),
    );
  }
}
