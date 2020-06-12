import 'package:flutter/material.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingPanel extends StatelessWidget {
  final Widget body;
  final double minHeight;
  final double maxHeight;
  final double borderRadius;
  final Function(double) onPanelSlide;
  final Widget Function(ScrollController) panelBuilder;

  const SlidingPanel({
    @required this.body,
    @required this.minHeight,
    @required this.panelBuilder,
    this.onPanelSlide,
    this.maxHeight,
    this.borderRadius = 16.0,
  })  : assert(body != null),
        assert(minHeight != null),
        assert(panelBuilder != null),
        assert(borderRadius != null);

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      backdropOpacity: 0.6,
      parallaxEnabled: true,
      backdropEnabled: true,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRadius),
        topRight: Radius.circular(borderRadius),
      ),
      minHeight: minHeight,
      maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.8,
      onPanelSlide: onPanelSlide,
      body: body,
      panelBuilder: panelBuilder,
    );
  }
}
