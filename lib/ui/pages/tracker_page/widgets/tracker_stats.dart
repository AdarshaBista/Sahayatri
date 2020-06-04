import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/ui/shared/widgets/stat_card.dart';

class TrackerStats extends StatelessWidget {
  final double height;
  final UserLocation userLocation;

  const TrackerStats({
    @required this.height,
    @required this.userLocation,
  })  : assert(height != null),
        assert(userLocation != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height - 28.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          StatCard(
            label: 'Altitide',
            count: '${userLocation.altitude.floor()} m',
            color: Colors.teal,
          ),
          StatCard(
            label: 'Speed',
            count: '${userLocation.speed.toStringAsFixed(1)} m/s',
            color: Colors.teal,
          ),
          StatCard(
            label: 'Accuracy',
            count: '${userLocation.accuracy.toStringAsFixed(1)} m',
            color: Colors.teal,
          ),
        ],
      ),
    );
  }
}
