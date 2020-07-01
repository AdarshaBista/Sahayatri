import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/resources.dart';

import 'package:latlong/latlong.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class PlaceMarker extends Marker {
  PlaceMarker({
    @required Color color,
    @required LatLng point,
    @required VoidCallback onTap,
  }) : super(
          point: point,
          builder: (context) => GestureDetector(
            onTap: onTap,
            child: ScaleAnimator(
              child: Image.asset(
                Images.kMarker,
                width: 24.0,
                height: 24.0,
                color: color,
              ),
            ),
          ),
        );
}
