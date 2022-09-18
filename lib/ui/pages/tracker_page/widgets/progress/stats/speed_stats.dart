import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/info_card.dart';
import 'package:sahayatri/ui/styles/styles.dart';

class SpeedStats extends StatelessWidget {
  const SpeedStats({super.key});

  @override
  Widget build(BuildContext context) {
    final trackerUpdate = context.watch<TrackerUpdate>();

    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 90.0,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 12.0,
      ),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        InfoCard(
          color: Colors.blue,
          icon: AppIcons.averageSpeed,
          title: '${trackerUpdate.averageSpeed.toStringAsFixed(1)} m/s',
          subtitle: 'Average Speed',
        ),
        InfoCard(
          color: Colors.red,
          icon: AppIcons.topSpeed,
          title: '${trackerUpdate.topSpeed.toStringAsFixed(1)} m/s',
          subtitle: 'Top Speed',
        ),
      ],
    );
  }
}
