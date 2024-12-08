import 'package:flutter/material.dart';

import 'package:sahayatri/core/utils/math_utls.dart';

import 'package:sahayatri/ui/pages/itinerary_page/widgets/itinerary_header.dart';
import 'package:sahayatri/ui/pages/itinerary_page/widgets/itinerary_map.dart';
import 'package:sahayatri/ui/pages/itinerary_page/widgets/itinerary_panel.dart';
import 'package:sahayatri/ui/widgets/common/sliding_panel.dart';

class ItineraryPage extends StatelessWidget {
  const ItineraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.textScalerOf(context).scale(1);
    final scale = MathUtils.mapRange(textScaleFactor, 0.25, 3.0, 0.7, 1.1);
    final minHeight = 75.0 * scale;

    return Scaffold(
      body: SlidingPanel(
        renderPanelSheet: false,
        body: const ItineraryMap(),
        collapsed: const ItineraryHeader(),
        panel: const ItineraryPanel(),
        minHeight: minHeight,
        maxHeight: MediaQuery.of(context).size.height,
      ),
    );
  }
}
