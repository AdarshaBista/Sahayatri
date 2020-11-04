import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:sahayatri/app/constants/configs.dart';

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
            Images.userMarker,
            width: 24.0,
            height: 24.0,
          ),
        );
}
