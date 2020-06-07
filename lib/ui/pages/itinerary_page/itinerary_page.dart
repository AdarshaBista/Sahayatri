import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/itinerary.dart';

import 'package:provider/provider.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

import 'package:sahayatri/ui/shared/widgets/pill.dart';
import 'package:sahayatri/ui/shared/widgets/close_icon.dart';
import 'package:sahayatri/ui/shared/widgets/sliding_panel.dart';
import 'package:sahayatri/ui/shared/widgets/itinerary_timeline.dart';
import 'package:sahayatri/ui/pages/itinerary_page/widgets/itinerary_map.dart';
import 'package:sahayatri/ui/pages/itinerary_page/widgets/itinerary_header.dart';

class ItineraryPage extends StatefulWidget {
  const ItineraryPage();

  @override
  _ItineraryPageState createState() => _ItineraryPageState();
}

class _ItineraryPageState extends State<ItineraryPage> {
  double panelOpenPercent = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingPanel(
        minHeight: 90.0,
        body: _buildMap(),
        panelBuilder: (sc) => _buildPanel(sc),
        onPanelSlide: (value) => setState(() {
          panelOpenPercent = value;
        }),
      ),
    );
  }

  Stack _buildMap() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        const ItineraryMap(),
        Positioned(
          top: 16.0,
          right: 16.0,
          child: Transform.scale(
            scale: 1.0 - panelOpenPercent,
            child: const SafeArea(child: CloseIcon()),
          ),
        ),
      ],
    );
  }

  Widget _buildPanel(ScrollController controller) {
    final itinerary = Provider.of<Itinerary>(context);

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
            const Pill(),
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
