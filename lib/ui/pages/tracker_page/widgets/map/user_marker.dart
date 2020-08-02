import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/resources.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_map/flutter_map.dart';

class UserMarker extends Marker {
  UserMarker({
    @required Coord point,
  })  : assert(point != null),
        super(
          width: 24.0,
          height: 24.0,
          point: point.toLatLng(),
          builder: (_) => Image.asset(
            Images.kUserMarker,
            width: 24.0,
            height: 24.0,
          ),
        );
}
