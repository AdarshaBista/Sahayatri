import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/map/custom_map.dart';
import 'package:sahayatri/ui/widgets/dialogs/map_dialog.dart';
import 'package:sahayatri/ui/pages/place_page/widgets/lodge_marker.dart';

class PlaceMapDialog extends StatelessWidget {
  final Place place;

  const PlaceMapDialog({
    @required this.place,
  }) : assert(place != null);

  @override
  Widget build(BuildContext context) {
    final lodges = place.lodges;
    final center = place.coord;

    return MapDialog(
      map: CustomMap(
        center: center,
        minZoom: 18.0,
        initialZoom: 18.5,
        children: [if (lodges.isNotEmpty) _LodgeMarkersLayer(lodges: lodges)],
        swPanBoundary: Coord(lat: center.lat - 0.005, lng: center.lng - 0.005),
        nePanBoundary: Coord(lat: center.lat + 0.005, lng: center.lng + 0.005),
      ),
    );
  }
}

class _LodgeMarkersLayer extends StatelessWidget {
  final List<Lodge> lodges;

  const _LodgeMarkersLayer({
    @required this.lodges,
  }) : assert(lodges != null);

  @override
  Widget build(BuildContext context) {
    return MarkerLayerWidget(
      options: MarkerLayerOptions(
        markers: [
          for (int i = 0; i < lodges.length; ++i)
            LodgeMarker(
              lodge: lodges[i],
              color: AppColors.accents[i % AppColors.accents.length],
            ),
        ],
      ),
    );
  }
}
