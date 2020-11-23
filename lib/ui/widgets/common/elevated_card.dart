import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class ElevatedCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final double radius;
  final Color shadowColor;
  final double elevation;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;

  const ElevatedCard({
    @required this.child,
    this.color,
    this.shadowColor = AppColors.dark,
    this.elevation = 2.0,
    this.radius = 4.0,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.borderRadius,
  })  : assert(child != null),
        assert(elevation != null),
        assert(radius != null),
        assert(margin != null),
        assert(padding != null),
        assert(shadowColor != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? context.c.background,
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
