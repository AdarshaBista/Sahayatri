import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final double elevation;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const CustomCard({
    @required this.child,
    this.color = AppColors.light,
    this.borderRadius = 12.0,
    this.elevation = 8.0,
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
    return Card(
      color: color,
      margin: margin,
      elevation: elevation,
      borderOnForeground: false,
      clipBehavior: Clip.antiAlias,
      shadowColor: AppColors.dark.withOpacity(0.6),
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
