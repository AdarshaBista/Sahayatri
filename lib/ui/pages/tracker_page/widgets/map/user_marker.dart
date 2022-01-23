import 'package:flutter/material.dart';

import 'package:sahayatri/core/constants/images.dart';

import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class UserMarker extends Marker {
  UserMarker({
    required LatLng point,
  })  : assert(point != null),
        super(
          width: 24.0,
          height: 24.0,
          point: point,
          builder: (_) {
            return Image.asset(
              Images.userMarker,
              width: 24.0,
              height: 24.0,
            );
          },
        );
}
