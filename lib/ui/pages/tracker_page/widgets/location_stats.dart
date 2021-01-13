import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/stat_card.dart';

class LocationStats extends StatelessWidget {
  const LocationStats();

  @override
  Widget build(BuildContext context) {
    final currentLocation = context.watch<TrackerUpdate>().currentLocation;

    return Container(
      height: 60.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          StatCard(
            label: 'Altitude',
            count: '${currentLocation.altitude.floor()} m',
            color: AppColors.primaryDark,
          ),
          StatCard(
            label: 'Speed',
            count: '${currentLocation.speed.toStringAsFixed(1)} m/s',
            color: AppColors.primaryDark,
          ),
          StatCard(
            label: 'Accuracy',
            count: '${currentLocation.accuracy.toStringAsFixed(1)} m',
            color: AppColors.primaryDark,
          ),
        ],
      ),
    );
  }
}
