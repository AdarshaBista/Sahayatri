import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/resources.dart';

import 'package:provider/provider.dart';
import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:sahayatri/ui/shared/widgets/stat_card.dart';

class LocationStats extends StatelessWidget {
  const LocationStats();

  @override
  Widget build(BuildContext context) {
    final trackerUpdate = context.watch<TrackerUpdate>();

    return Container(
      height: AppConfig.kTrackerPanelHeight - 32.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          StatCard(
            label: 'Altitude',
            count: '${trackerUpdate.userLocation.altitude.floor()} m',
            color: Colors.teal,
          ),
          StatCard(
            label: 'Speed',
            count: '${trackerUpdate.userLocation.speed.toStringAsFixed(1)} m/s',
            color: Colors.teal,
          ),
          StatCard(
            label: 'Accuracy',
            count: '${trackerUpdate.userLocation.accuracy.toStringAsFixed(1)} m',
            color: Colors.teal,
          ),
        ],
      ),
    );
  }
}
