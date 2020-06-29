import 'package:flutter/material.dart';

import 'package:sahayatri/blocs/tracker_bloc/tracker_bloc.dart';

import 'package:sahayatri/ui/shared/widgets/pill.dart';
import 'package:sahayatri/ui/shared/widgets/sliding_panel.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/tracker_map.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/tracker_stats.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/next_stop_card.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/distance_stats.dart';

class TrackerPanel extends StatelessWidget {
  static const double kCollapsedHeight = 100.0;
  final TrackerSuccess state;

  const TrackerPanel({
    @required this.state,
  }) : assert(state != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingPanel(
        parallaxEnabled: false,
        minHeight: kCollapsedHeight,
        margin: const EdgeInsets.all(16.0),
        body: TrackerMap(
          userIndex: state.userIndex,
          userLocation: state.userLocation,
        ),
        panelBuilder: (sc) => _buildPanel(sc),
      ),
    );
  }

  Widget _buildPanel(ScrollController controller) {
    return SingleChildScrollView(
      controller: controller,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 4.0),
          const Pill(),
          TrackerStats(
            height: kCollapsedHeight,
            userLocation: state.userLocation,
          ),
          const Divider(height: 20.0),
          NextStopCard(
            eta: state.eta,
            place: state.nextStop,
          ),
          const SizedBox(height: 12.0),
          DistanceStats(
            walked: state.distanceWalked,
            remaining: state.distanceRemaining,
          ),
        ],
      ),
    );
  }
}
