import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class ElevatedCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final Color shadowColor;
  final double elevation;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const ElevatedCard({
    @required this.child,
    this.color = AppColors.light,
    this.shadowColor = AppColors.dark,
    this.elevation = 4.0,
    this.borderRadius = 10.0,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
  })  : assert(child != null),
        assert(color != null),
        assert(elevation != null),
        assert(borderRadius != null),
        assert(margin != null),
        assert(padding != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            spreadRadius: elevation,
            color: shadowColor.withOpacity(0.15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: child,
      ),
    );
  }
}
