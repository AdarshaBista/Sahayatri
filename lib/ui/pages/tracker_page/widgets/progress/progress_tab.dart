import 'package:flutter/material.dart';

import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/tracker_actions.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/graphs/speed_graph.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/stats/tracker_stats.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/graphs/elevation_graph.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/next_checkpoint/next_checkpoint_card.dart';

class ProgressTab extends StatelessWidget {
  const ProgressTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      physics: const BouncingScrollPhysics(),
      children: const [
        TrackerStats(),
        SizedBox(height: 12.0),
        TrackerActions(),
        SizedBox(height: 20.0),
        NextCheckpointCard(),
        SizedBox(height: 20.0),
        ElevationGraph(),
        SizedBox(height: 20.0),
        SpeedGraph(),
      ],
    );
  }
}
