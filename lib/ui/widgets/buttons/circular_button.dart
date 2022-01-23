import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class CircularButton extends StatelessWidget {
  final double size;
  final Color color;
  final IconData icon;
  final double padding;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const CircularButton({
    required this.icon,
    this.onTap,
    this.size = 18.0,
    this.padding = 8.0,
    this.color = AppColors.light,
    this.backgroundColor = AppColors.dark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ScaleAnimator(
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: size,
            color: color,
          ),
        ),
      ),
    );
  }
}
