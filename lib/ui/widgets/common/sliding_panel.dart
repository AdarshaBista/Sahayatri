import 'package:flutter/material.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sahayatri/ui/styles/styles.dart';

class SlidingPanel extends StatelessWidget {
  final Widget body;
  final Widget panel;
  final Widget collapsed;
  final double minHeight;
  final double maxHeight;
  final double snapPoint;
  final double borderRadius;
  final EdgeInsets margin;
  final bool backdropEnabled;
  final bool parallaxEnabled;
  final bool renderPanelSheet;
  final Function(double) onPanelSlide;
  final Widget Function(ScrollController) panelBuilder;

  const SlidingPanel({
    @required this.body,
    @required this.minHeight,
    this.panel,
    this.collapsed,
    this.maxHeight,
    this.snapPoint,
    this.onPanelSlide,
    this.panelBuilder,
    this.borderRadius = 12.0,
    this.backdropEnabled = true,
    this.parallaxEnabled = false,
    this.renderPanelSheet = true,
    this.margin = EdgeInsets.zero,
  })  : assert(body != null),
        assert(margin != null),
        assert(minHeight != null),
        assert(borderRadius != null),
        assert(backdropEnabled != null),
        assert(parallaxEnabled != null),
        assert(renderPanelSheet != null);

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(borderRadius);

    return SlidingUpPanel(
      snapPoint: snapPoint,
      parallaxOffset: 0.5,
      backdropOpacity: 0.6,
      color: context.theme.cardColor,
      backdropEnabled: backdropEnabled,
      parallaxEnabled: parallaxEnabled,
      renderPanelSheet: renderPanelSheet,
      backdropColor: AppColors.dark,
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
      collapsed: collapsed,
      panelBuilder: panelBuilder,
    );
  }
}
