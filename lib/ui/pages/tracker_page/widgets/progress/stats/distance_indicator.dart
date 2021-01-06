import 'package:flutter/material.dart';

import 'package:sahayatri/core/utils/format_utils.dart';
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
        innerWidget: (_) => _buildDistanceInfo(
          context,
          distanceCovered,
          distanceRemaining,
        ),
        appearance: CircularSliderAppearance(
          size: 180.0,
          startAngle: 120.0,
          angleRange: 300.0,
          customWidths: CustomSliderWidths(
            trackWidth: 5.0,
            progressBarWidth: 10.0,
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

  Widget _buildDistanceInfo(BuildContext context, double covered, double remaining) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStat(context, covered, 'covered', AppColors.primaryDark),
        const SizedBox(height: 16.0),
        _buildStat(context, remaining, 'remaining', AppColors.secondary),
      ],
    );
  }

  Widget _buildStat(BuildContext context, double distance, String label, Color color) {
    return Column(
      children: [
        Text(
          FormatUtils.distance(distance),
          style: context.t.headline4.bold.withColor(color),
        ),
        const SizedBox(height: 2.0),
        Text(
          label,
          style: context.t.headline6,
        ),
      ],
    );
  }
}
