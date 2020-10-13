import 'package:flutter/material.dart';

import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/stopwatch_tile.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/tracker_actions.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/distance_covered_bar.dart';

class TrackerStats extends StatelessWidget {
  const TrackerStats();

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 4.0),
            StopwatchTile(),
            SizedBox(height: 8.0),
            TrackerActions(),
            SizedBox(height: 16.0),
            DistanceCoveredBar(),
          ],
        ),
      ),
    );
  }
}
