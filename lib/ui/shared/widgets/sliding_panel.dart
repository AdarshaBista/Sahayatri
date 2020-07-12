import 'package:flutter/material.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingPanel extends StatelessWidget {
  final Widget body;
  final double minHeight;
  final double maxHeight;
  final double snapPoint;
  final double borderRadius;
  final EdgeInsets margin;
  final Function(double) onPanelSlide;
  final Widget Function(ScrollController) panelBuilder;

  const SlidingPanel({
    @required this.body,
    @required this.minHeight,
    @required this.panelBuilder,
    this.onPanelSlide,
    this.maxHeight,
    this.snapPoint,
    this.borderRadius = 16.0,
    this.margin = EdgeInsets.zero,
  })  : assert(body != null),
        assert(margin != null),
        assert(minHeight != null),
        assert(borderRadius != null),
        assert(panelBuilder != null);

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(borderRadius);

    return SlidingUpPanel(
      snapPoint: snapPoint,
      backdropOpacity: 0.6,
      backdropEnabled: true,
      borderRadius: BorderRadius.only(
        topLeft: radius,
        topRight: radius,
        bottomLeft: margin == EdgeInsets.zero ? Radius.zero : radius,
        bottomRight: margin == EdgeInsets.zero ? Radius.zero : radius,
      ),
      margin: margin,
      minHeight: minHeight,
      maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.8,
      onPanelSlide: onPanelSlide,
      body: body,
      panelBuilder: panelBuilder,
    );
  }
}
