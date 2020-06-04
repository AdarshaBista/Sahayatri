import 'package:flutter/material.dart';

class GradientContainer extends Container {
  GradientContainer({
    @required List<Color> gradientColors,
    List<double> gradientStops,
    AlignmentGeometry gradientBegin = Alignment.topCenter,
    AlignmentGeometry gradientEnd = Alignment.bottomCenter,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    AlignmentGeometry alignment = Alignment.center,
    double width,
    double height,
    Widget child,
  }) : super(
          width: width,
          height: height,
          margin: margin,
          padding: padding,
          alignment: alignment,
          foregroundDecoration: BoxDecoration(
            backgroundBlendMode: BlendMode.srcOver,
            gradient: LinearGradient(
              begin: gradientBegin,
              end: gradientEnd,
              stops: gradientStops,
              colors: gradientColors,
            ),
          ),
          child: child,
        );
}
