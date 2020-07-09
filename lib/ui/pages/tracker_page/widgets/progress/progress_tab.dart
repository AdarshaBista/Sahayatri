import 'package:flutter/material.dart';

import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/tracker_stats.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/next_stop_card.dart';

class ProgressTab extends StatelessWidget {
  const ProgressTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TrackerStats(),
        SizedBox(height: 12.0),
        NextStopCard(),
      ],
    );
  }
}
