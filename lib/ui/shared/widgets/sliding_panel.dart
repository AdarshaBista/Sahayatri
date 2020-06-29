import 'package:flutter/material.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingPanel extends StatelessWidget {
  final Widget body;
  final double minHeight;
  final double maxHeight;
  final double borderRadius;
  final EdgeInsets margin;
  final bool parallaxEnabled;
  final Function(double) onPanelSlide;
  final Widget Function(ScrollController) panelBuilder;

  const SlidingPanel({
    @required this.body,
    @required this.minHeight,
    @required this.panelBuilder,
    this.onPanelSlide,
    this.maxHeight,
    this.borderRadius = 16.0,
    this.parallaxEnabled = true,
    this.margin = EdgeInsets.zero,
  })  : assert(body != null),
        assert(margin != null),
        assert(minHeight != null),
        assert(panelBuilder != null),
        assert(borderRadius != null),
        assert(parallaxEnabled != null);

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(borderRadius);

    return SlidingUpPanel(
      backdropOpacity: 0.6,
      backdropEnabled: true,
      parallaxEnabled: parallaxEnabled,
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
