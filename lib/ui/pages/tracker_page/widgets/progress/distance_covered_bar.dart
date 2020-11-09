import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class DistanceCoveredBar extends StatelessWidget {
  const DistanceCoveredBar();

  @override
  Widget build(BuildContext context) {
    final distanceCovered =
        context.select<TrackerUpdate, double>((u) => u.distanceCovered);
    final distanceRemaining =
        context.select<TrackerUpdate, double>((u) => u.distanceRemaining);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 8.0,
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.primaryLight,
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
              thumbColor: AppColors.primary,
              thumbShape: const RoundSliderThumbShape(
                elevation: 0.0,
                pressedElevation: 0.0,
                enabledThumbRadius: 5.0,
              ),
            ),
            child: Slider(
              max: distanceRemaining + distanceCovered,
              value: distanceCovered,
              onChanged: (_) {},
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              _buildStat(distanceCovered, 'covered', true),
              const Spacer(),
              _buildStat(distanceRemaining, 'remaining', false),
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
        const SizedBox(height: 2.0),
        Text(
          label,
          style: AppTextStyles.extraSmall,
        ),
      ],
    );
  }
}
