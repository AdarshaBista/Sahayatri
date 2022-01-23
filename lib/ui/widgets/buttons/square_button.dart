import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/vertical_button.dart';

class SquareButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final double borderRadius;
  final Color? color;
  final double? size;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const SquareButton({
    required this.icon,
    required this.label,
    this.onTap,
    this.color,
    this.size = 80.0,
    this.backgroundColor,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primaryLight,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: VerticalButton(
            label: label,
            icon: icon,
            color: color,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
