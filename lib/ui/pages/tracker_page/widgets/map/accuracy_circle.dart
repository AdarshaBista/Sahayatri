import 'package:flutter/material.dart';

import 'package:latlong/latlong.dart';

import 'package:flutter_map/flutter_map.dart';

class AccuracyCircle extends CircleMarker {
  AccuracyCircle({
    required LatLng point,
    required Color color,
    required double radius,
  })  : assert(point != null),
        assert(color != null),
        assert(radius != null),
        super(
          point: point,
          radius: radius,
          useRadiusInMeter: true,
          borderStrokeWidth: 2.0,
          color: color.withOpacity(0.2),
          borderColor: color.withOpacity(0.5),
        );
}
