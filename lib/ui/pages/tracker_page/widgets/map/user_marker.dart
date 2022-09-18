import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:sahayatri/core/constants/images.dart';

class UserMarker extends Marker {
  UserMarker({
    required LatLng point,
  }) : super(
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
