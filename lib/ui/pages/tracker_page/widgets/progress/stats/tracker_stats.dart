import 'package:flutter/material.dart';

import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/stats/speed_stats.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/stats/stopwatch_tile.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/stats/tracker_actions.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/stats/distance_indicator.dart';

class TrackerStats extends StatelessWidget {
  const TrackerStats();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: const [
              DistanceIndicator(),
              Positioned(
                bottom: -34.0,
                child: StopwatchTile(),
              ),
            ],
          ),
          const SizedBox(height: 48.0),
          const TrackerActions(),
          const SizedBox(height: 12.0),
          const SpeedStats(),
        ],
      ),
    );
  }
}
