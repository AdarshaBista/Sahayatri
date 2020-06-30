import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sahayatri/core/models/tracker_data.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:community_material_icon/community_material_icon.dart';

class DistanceStats extends StatelessWidget {
  const DistanceStats();

  @override
  Widget build(BuildContext context) {
    final trackerData = context.watch<TrackerData>();

    return FadeAnimator(
      child: CustomCard(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStat(
              _formatDuration(trackerData.elapsed),
              'elapsed',
              CommunityMaterialIcons.timer_outline,
              Colors.blue,
            ),
            const Divider(height: 24.0),
            _buildStat(
              trackerData.distanceWalked.toStringAsFixed(0),
              'metres walked',
              CommunityMaterialIcons.shoe_print,
              Colors.green,
            ),
            const Divider(height: 24.0),
            _buildStat(
              trackerData.distanceRemaining.toStringAsFixed(0),
              'metres remaining',
              CommunityMaterialIcons.map_marker_distance,
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String stat, String label, IconData icon, Color color) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Icon(
          icon,
          color: color,
          size: 22.0,
        ),
        const SizedBox(width: 8.0),
        Text(
          stat,
          style: AppTextStyles.large.bold,
        ),
        const SizedBox(width: 8.0),
        Text(
          label,
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
