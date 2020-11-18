import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:provider/provider.dart';

import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:sahayatri/ui/styles/styles.dart';

class DistanceIndicator extends StatelessWidget {
  const DistanceIndicator();

  @override
  Widget build(BuildContext context) {
    final distanceCovered =
        context.select<TrackerUpdate, double>((u) => u.distanceCovered);
    final distanceRemaining =
        context.select<TrackerUpdate, double>((u) => u.distanceRemaining);

    return Center(
      child: SleekCircularSlider(
        initialValue: distanceCovered,
        max: distanceRemaining + distanceCovered,
        innerWidget: (_) => _buildDistanceInfo(distanceCovered, distanceRemaining),
        appearance: CircularSliderAppearance(
          size: 180.0,
          startAngle: 120.0,
          angleRange: 300.0,
          customWidths: CustomSliderWidths(
            trackWidth: 4.0,
            progressBarWidth: 8.0,
          ),
          customColors: CustomSliderColors(
            dynamicGradient: true,
            dotColor: AppColors.light,
            trackColor: AppColors.primaryLight,
            progressBarColors: AppColors.userTrackGradient,
          ),
        ),
      ),
    );
  }

  Widget _buildDistanceInfo(double covered, double remaining) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStat(covered, 'covered', AppColors.primaryDark),
        const SizedBox(height: 16.0),
        _buildStat(remaining, 'remaining', AppColors.secondary),
      ],
    );
  }

  Widget _buildStat(double distance, String label, Color color) {
    return Column(
      children: [
        Text(
          _formatDistance(distance),
          style: AppTextStyles.medium.bold.withColor(color),
        ),
        const SizedBox(height: 2.0),
        Text(
          label,
          style: AppTextStyles.extraSmall,
        ),
      ],
    );
  }

  String _formatDistance(double distance) {
    if (distance < 2000.0) return '${distance.toStringAsFixed(0)} m';

    final distanceInKm = (distance / 1000.0).toStringAsFixed(2);
    return '$distanceInKm km';
  }
}
