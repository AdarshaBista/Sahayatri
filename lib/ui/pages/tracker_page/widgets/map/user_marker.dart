import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:sahayatri/core/constants/images.dart';

class UserMarker extends Marker {
  UserMarker({
    required super.point,
  }) : super(
          width: 24.0,
          height: 24.0,
          child: Image.asset(
            Images.userMarker,
            width: 24.0,
            height: 24.0,
          ),
        );
}
