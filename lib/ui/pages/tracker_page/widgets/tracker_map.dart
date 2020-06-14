import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_map.dart';
import 'package:community_material_icon/community_material_icon.dart';

class TrackerMap extends StatelessWidget {
  final UserLocation userLocation;

  const TrackerMap({
    @required this.userLocation,
  }) : assert(userLocation != null);

  @override
  Widget build(BuildContext context) {
    final Coord center = userLocation.coord;

    return CustomMap(
      center: center,
      markerLayerOptions: _buildMarker(context, center),
    );
  }

  MarkerLayerOptions _buildMarker(BuildContext context, Coord center) {
    return MarkerLayerOptions(
      markers: [
        Marker(
          width: 32.0,
          height: 32.0,
          point: center.toLatLng(),
          anchorPos: AnchorPos.align(AnchorAlign.top),
          builder: (context) => const Icon(
            CommunityMaterialIcons.map_marker,
            color: AppColors.dark,
            size: 32.0,
          ),
        ),
      ],
    );
  }
}
