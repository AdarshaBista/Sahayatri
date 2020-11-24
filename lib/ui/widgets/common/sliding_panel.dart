import 'package:flutter/material.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sahayatri/ui/styles/styles.dart';

class SlidingPanel extends StatelessWidget {
  final Widget body;
  final Widget panel;
  final double minHeight;
  final double maxHeight;
  final double snapPoint;
  final double borderRadius;
  final EdgeInsets margin;
  final bool parallaxEnabled;
  final Function(double) onPanelSlide;
  final Widget Function(ScrollController) panelBuilder;

  const SlidingPanel({
    @required this.body,
    @required this.minHeight,
    this.panel,
    this.maxHeight,
    this.snapPoint,
    this.onPanelSlide,
    this.panelBuilder,
    this.borderRadius = 12.0,
    this.parallaxEnabled = false,
    this.margin = EdgeInsets.zero,
  })  : assert(body != null),
        assert(margin != null),
        assert(minHeight != null),
        assert(borderRadius != null),
        assert(parallaxEnabled != null);

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(borderRadius);

    return SlidingUpPanel(
      snapPoint: snapPoint,
      parallaxOffset: 0.5,
      backdropOpacity: 0.6,
      backdropEnabled: true,
      color: context.theme.cardColor,
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
      panel: panel,
      panelBuilder: panelBuilder,
    );
  }
}
