import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sahayatri/core/models/tracker_data.dart';

import 'package:sahayatri/ui/shared/widgets/stat_card.dart';

class LocationStats extends StatelessWidget {
  final double height;

  const LocationStats({
    @required this.height,
  }) : assert(height != null);

  @override
  Widget build(BuildContext context) {
    final trackerData = context.watch<TrackerData>();

    return Container(
      height: height - 32.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          StatCard(
            label: 'Altitude',
            count: '${trackerData.userLocation.altitude.floor()} m',
            color: Colors.teal,
          ),
          StatCard(
            label: 'Speed',
            count: '${trackerData.userLocation.speed.toStringAsFixed(1)} m/s',
            color: Colors.teal,
          ),
          StatCard(
            label: 'Accuracy',
            count: '${trackerData.userLocation.accuracy.toStringAsFixed(1)} m',
            color: Colors.teal,
          ),
        ],
      ),
    );
  }
}
