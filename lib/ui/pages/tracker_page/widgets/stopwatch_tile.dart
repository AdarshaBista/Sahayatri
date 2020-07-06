import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sahayatri/core/models/tracker_data.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';

class StopwatchTile extends StatelessWidget {
  const StopwatchTile();

  @override
  Widget build(BuildContext context) {
    final trackerData = context.watch<TrackerData>();

    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        const Icon(
          CommunityMaterialIcons.timer_outline,
          color: AppColors.dark,
          size: 22.0,
        ),
        const SizedBox(width: 8.0),
        Text(
          _formatDuration(trackerData.elapsed),
          style: AppTextStyles.large.bold,
        ),
        const SizedBox(width: 8.0),
        Text(
          'elapsed',
          style: AppTextStyles.small,
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    return [duration.inHours, duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }
}
