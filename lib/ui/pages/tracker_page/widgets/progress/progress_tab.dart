import 'package:flutter/material.dart';

import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/graphs/elevation_graph.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/graphs/speed_graph.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/next_checkpoint/next_checkpoint_card.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/stats/tracker_stats.dart';

class ProgressTab extends StatelessWidget {
  const ProgressTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      physics: const BouncingScrollPhysics(),
      children: const [
        TrackerStats(),
        SizedBox(height: 24.0),
        SpeedGraph(),
        SizedBox(height: 24.0),
        ElevationGraph(),
        SizedBox(height: 24.0),
        NextCheckpointCard(),
      ],
    );
  }
}
