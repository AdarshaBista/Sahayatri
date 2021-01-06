import 'package:flutter/material.dart';

import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/tracker_stats.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/next_checkpoint_card.dart';

class ProgressTab extends StatelessWidget {
  const ProgressTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      children: const [
        TrackerStats(),
        SizedBox(height: 6.0),
        NextCheckpointCard(),
        SizedBox(height: 16.0),
      ],
    );
  }
}
