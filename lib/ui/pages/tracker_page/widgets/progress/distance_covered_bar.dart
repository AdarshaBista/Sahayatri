import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class DistanceCoveredBar extends StatelessWidget {
  const DistanceCoveredBar();

  @override
  Widget build(BuildContext context) {
    final trackerUpdate = context.watch<TrackerUpdate>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          SliderTheme(
            data: const SliderThemeData(
              trackHeight: 8.0,
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.secondary,
              overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
              thumbColor: AppColors.primary,
              thumbShape: RoundSliderThumbShape(
                elevation: 0.0,
                pressedElevation: 0.0,
                enabledThumbRadius: 5.0,
              ),
            ),
            child: Slider(
              max: trackerUpdate.distanceRemaining + trackerUpdate.distanceCovered,
              value: trackerUpdate.distanceCovered,
              onChanged: (_) {},
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              _buildStat(trackerUpdate.distanceCovered, 'covered', true),
              const Spacer(),
              _buildStat(trackerUpdate.distanceRemaining, 'remaining', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(double stat, String label, bool isFirst) {
    return Column(
      crossAxisAlignment: isFirst ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          '${stat.toStringAsFixed(0)} m',
          style: AppTextStyles.medium.bold,
        ),
        Text(
          label,
          style: AppTextStyles.extraSmall,
        ),
      ],
    );
  }
}
