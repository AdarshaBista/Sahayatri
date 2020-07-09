import 'package:flutter/material.dart';

import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/stopwatch_tile.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/tracker_actions.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/distance_covered_bar.dart';

class TrackerStats extends StatelessWidget {
  const TrackerStats();

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: CustomCard(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            StopwatchTile(),
            SizedBox(height: 12.0),
            TrackerActions(),
            SizedBox(height: 12.0),
            DistanceCoveredBar(),
          ],
        ),
      ),
    );
  }
}