import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/itinerary.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/widgets/common/sliding_panel.dart';
import 'package:sahayatri/ui/widgets/common/itinerary_timeline.dart';
import 'package:sahayatri/ui/pages/itinerary_page/widgets/itinerary_map.dart';
import 'package:sahayatri/ui/pages/itinerary_page/widgets/itinerary_header.dart';

class ItineraryPage extends StatelessWidget {
  const ItineraryPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingPanel(
        body: const ItineraryMap(),
        panelBuilder: (sc) => _buildPanel(context, sc),
        minHeight: MediaQuery.of(context).size.height * 0.2,
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
    );
  }

  Widget _buildPanel(BuildContext context, ScrollController controller) {
    final itinerary = Provider.of<Itinerary>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
      child: Column(
        children: [
          const ItineraryHeader(),
          const SizedBox(height: 10.0),
          const Divider(),
          Expanded(
            child: ItineraryTimeline(
              controller: controller,
              checkpoints: itinerary.checkpoints,
            ),
          ),
        ],
      ),
    );
  }
}
