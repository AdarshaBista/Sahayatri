import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';

class AccuracyCircle extends CircleMarker {
  AccuracyCircle({
    required Color color,
    required super.point,
    required super.radius,
  }) : super(
          useRadiusInMeter: true,
          borderStrokeWidth: 2.0,
          color: color.withOpacity(0.2),
          borderColor: color.withOpacity(0.5),
        );
}
