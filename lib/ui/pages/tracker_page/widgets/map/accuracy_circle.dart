import 'package:flutter/material.dart';

import 'package:latlong2/latlong.dart';

import 'package:flutter_map/flutter_map.dart';

class AccuracyCircle extends CircleMarker {
  AccuracyCircle({
    required LatLng point,
    required Color color,
    required double radius,
  }) : super(
          point: point,
          radius: radius,
          useRadiusInMeter: true,
          borderStrokeWidth: 2.0,
          color: color.withOpacity(0.2),
          borderColor: color.withOpacity(0.5),
        );
}
