import 'package:flutter/material.dart';

import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/timer_stat.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/distance_stat.dart';

class StatsCard extends StatelessWidget {
  const StatsCard();

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: CustomCard(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TimerStat(),
            SizedBox(height: 20.0),
            DistanceStat(),
          ],
        ),
      ),
    );
  }
}
