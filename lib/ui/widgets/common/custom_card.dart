import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double elevation;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Color? color;

  const CustomCard({
    super.key,
    required this.child,
    this.color,
    this.borderRadius = 6.0,
    this.elevation = 0.0,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      elevation: elevation,
      borderOnForeground: false,
      clipBehavior: Clip.antiAlias,
      color: color ?? context.c.surface,
      shadowColor: AppColors.dark.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
