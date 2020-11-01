import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final bool isForeground;
  final double borderRadius;
  final List<Color> gradientColors;
  final List<double> gradientStops;
  final AlignmentGeometry alignment;
  final AlignmentGeometry gradientEnd;
  final AlignmentGeometry gradientBegin;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const GradientContainer({
    @required this.gradientColors,
    this.gradientStops,
    this.isForeground = true,
    this.borderRadius = 0.0,
    this.gradientEnd = Alignment.topCenter,
    this.gradientBegin = Alignment.bottomCenter,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.child,
  })  : assert(margin != null),
        assert(padding != null),
        assert(alignment != null),
        assert(isForeground != null),
        assert(borderRadius != null),
        assert(gradientEnd != null),
        assert(gradientBegin != null),
        assert(gradientColors != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      alignment: alignment,
      decoration: isForeground ? null : _getDecoration(),
      foregroundDecoration: !isForeground ? null : _getDecoration(),
    );
  }

  BoxDecoration _getDecoration() {
    return BoxDecoration(
      backgroundBlendMode: BlendMode.srcOver,
      borderRadius: BorderRadius.circular(borderRadius),
      gradient: LinearGradient(
        begin: gradientBegin,
        end: gradientEnd,
        stops: gradientStops,
        colors: gradientColors,
      ),
    );
  }
}
