import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingPanel extends StatelessWidget {
  final Widget body;
  final double minHeight;
  final Function(double) onPanelSlide;
  final Widget Function(ScrollController) panelBuilder;

  const SlidingPanel({
    @required this.body,
    @required this.minHeight,
    @required this.onPanelSlide,
    @required this.panelBuilder,
  })  : assert(body != null),
        assert(minHeight != null),
        assert(panelBuilder != null);

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      color: AppColors.background,
      parallaxOffset: 0.1,
      backdropOpacity: 0.6,
      isDraggable: true,
      parallaxEnabled: true,
      backdropEnabled: true,
      renderPanelSheet: true,
      backdropTapClosesPanel: true,
      slideDirection: SlideDirection.UP,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
      minHeight: minHeight,
      maxHeight: MediaQuery.of(context).size.height * 0.7,
      onPanelSlide: onPanelSlide,
      body: body,
      panelBuilder: panelBuilder,
    );
  }
}
