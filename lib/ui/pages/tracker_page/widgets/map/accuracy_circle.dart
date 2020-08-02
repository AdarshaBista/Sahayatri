import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_map/flutter_map.dart';

class AccuracyCircle extends CircleMarker {
  AccuracyCircle({
    @required Coord point,
    @required Color color,
    @required double radius,
  })  : assert(point != null),
        assert(color != null),
        assert(radius != null),
        super(
          radius: radius,
          useRadiusInMeter: true,
          borderStrokeWidth: 2.0,
          point: point.toLatLng(),
          color: color.withOpacity(0.2),
          borderColor: color.withOpacity(0.5),
        );
}
