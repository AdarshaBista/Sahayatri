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
    this.elevation = 6.0,
    this.borderRadius = 8.0,
    this.padding = EdgeInsets.zero,
    this.margin = const EdgeInsets.all(12.0),
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
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            spreadRadius: elevation,
            color: shadowColor.withOpacity(0.12),
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
