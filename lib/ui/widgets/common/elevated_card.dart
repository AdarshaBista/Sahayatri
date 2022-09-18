import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class ElevatedCard extends StatelessWidget {
  final Widget child;
  final double radius;
  final double elevation;
  final Color shadowColor;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final BorderRadius? borderRadius;

  const ElevatedCard({
    super.key,
    required this.child,
    this.color,
    this.shadowColor = AppColors.dark,
    this.elevation = 2.0,
    this.radius = 6.0,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? context.theme.cardColor,
        borderRadius: borderRadius ?? BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            spreadRadius: elevation,
            color: shadowColor.withOpacity(0.12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius),
        child: child,
      ),
    );
  }
}
