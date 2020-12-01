import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class CloseIcon extends StatelessWidget {
  final double size;
  final Color iconColor;
  final IconData iconData;
  final VoidCallback onTap;
  final Color backgroundColor;

  const CloseIcon({
    this.onTap,
    this.size = 18.0,
    this.iconData = Icons.close,
    this.iconColor = AppColors.light,
    this.backgroundColor = AppColors.dark,
  })  : assert(size != null),
        assert(iconData != null),
        assert(iconColor != null),
        assert(backgroundColor != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.of(context).pop(),
      child: ScaleAnimator(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconData,
            size: size,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
