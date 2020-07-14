import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/itinerary.dart';

import 'package:provider/provider.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

import 'package:sahayatri/ui/shared/widgets/sliding_panel.dart';
import 'package:sahayatri/ui/shared/widgets/itinerary_timeline.dart';
import 'package:sahayatri/ui/shared/widgets/drag_indicator_pill.dart';
import 'package:sahayatri/ui/pages/itinerary_page/widgets/itinerary_map.dart';
import 'package:sahayatri/ui/pages/itinerary_page/widgets/itinerary_header.dart';

class ItineraryPage extends StatelessWidget {
  const ItineraryPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingPanel(
        minHeight: 90.0,
        body: const ItineraryMap(),
        panelBuilder: (sc) => _buildPanel(context, sc),
      ),
    );
  }

  Widget _buildPanel(BuildContext context, ScrollController controller) {
    final itinerary = Provider.of<Itinerary>(context, listen: false);

    return SlideAnimator(
      begin: const Offset(0.0, 0.2),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 20.0,
        ),
        child: Column(
          children: [
            const SizedBox(height: 4.0),
            const DragIndicatorPill(),
            const ItineraryHeader(),
            const Divider(),
            Expanded(
              child: ItineraryTimeline(
                controller: controller,
                checkpoints: itinerary.checkpoints,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
