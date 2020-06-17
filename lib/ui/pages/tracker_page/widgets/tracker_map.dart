import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/values.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/shared/widgets/custom_map.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class TrackerMap extends StatelessWidget {
  final UserLocation userLocation;

  const TrackerMap({
    @required this.userLocation,
  }) : assert(userLocation != null);

  @override
  Widget build(BuildContext context) {
    final Coord center = userLocation.coord;

    return CustomMap(
      center: center,
      trackLocation: true,
      markerLayerOptions: _buildMarker(center),
      circleLayerOptions: _buildAccuracyCircle(center),
    );
  }

  MarkerLayerOptions _buildMarker(Coord center) {
    return MarkerLayerOptions(
      markers: [
        Marker(
          width: 32.0,
          height: 32.0,
          point: center.toLatLng(),
          builder: (context) => ScaleAnimator(
            child: Transform.rotate(
              angle: userLocation.bearing,
              child: Image.asset(
                Values.kUserMarkerImage,
                width: 24.0,
                height: 24.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  CircleLayerOptions _buildAccuracyCircle(Coord center) {
    return CircleLayerOptions(
      circles: [
        CircleMarker(
          point: center.toLatLng(),
          borderStrokeWidth: 2.0,
          color: Colors.teal.withOpacity(0.2),
          borderColor: Colors.teal.withOpacity(0.5),
          useRadiusInMeter: true,
          radius: userLocation.accuracy,
        ),
      ],
    );
  }
}
