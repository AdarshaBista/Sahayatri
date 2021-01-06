import 'package:flutter/material.dart';

import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/stats/stopwatch_tile.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/stats/distance_indicator.dart';

class TrackerStats extends StatelessWidget {
  const TrackerStats();

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: Stack(
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
      ),
    );
  }
}
