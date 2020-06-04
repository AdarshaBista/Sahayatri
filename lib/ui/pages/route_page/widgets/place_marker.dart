import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/values.dart';

import 'package:latlong/latlong.dart';

import 'package:flutter_map/flutter_map.dart';

class PlaceMarker extends Marker {
  PlaceMarker({
    @required Color color,
    @required LatLng point,
    @required VoidCallback onTap,
  }) : super(
          point: point,
          builder: (context) => GestureDetector(
            onTap: onTap,
            child: Image.asset(
              Values.kMarkerImage,
              width: 24.0,
              height: 24.0,
              color: color,
            ),
          ),
        );
}
