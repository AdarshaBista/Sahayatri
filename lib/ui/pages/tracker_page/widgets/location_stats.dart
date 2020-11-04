import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/stat_card.dart';

class LocationStats extends StatelessWidget {
  const LocationStats();

  @override
  Widget build(BuildContext context) {
    final trackerUpdate = context.watch<TrackerUpdate>();

    return Container(
      height: UiConfig.trackerPanelHeight - 32.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          StatCard(
            label: 'Altitude',
            count: '${trackerUpdate.currentLocation.altitude.floor()} m',
            color: AppColors.primaryDark,
          ),
          StatCard(
            label: 'Speed',
            count: '${trackerUpdate.currentLocation.speed.toStringAsFixed(1)} m/s',
            color: AppColors.primaryDark,
          ),
          StatCard(
            label: 'Accuracy',
            count: '${trackerUpdate.currentLocation.accuracy.toStringAsFixed(1)} m',
            color: AppColors.primaryDark,
          ),
        ],
      ),
    );
  }
}
