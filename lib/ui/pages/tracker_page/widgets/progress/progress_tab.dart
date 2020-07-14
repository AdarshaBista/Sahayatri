import 'package:flutter/material.dart';

import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/tracker_stats.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/next_checkpoint_card.dart';

class ProgressTab extends StatelessWidget {
  const ProgressTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: const [
        TrackerStats(),
        SizedBox(height: 12.0),
        NextCheckpointCard(),
        SizedBox(height: 16.0),
      ],
    );
  }
}
