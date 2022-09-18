import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/models/place.dart';

import 'package:sahayatri/ui/pages/place_page/widgets/lodge_marker.dart';
import 'package:sahayatri/ui/widgets/dialogs/map_dialog.dart';
import 'package:sahayatri/ui/widgets/map/custom_map.dart';

class PlaceMapDialog extends StatelessWidget {
  final Place place;

  const PlaceMapDialog({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    final lodges = place.lodges;
    final center = place.coord;

    return MapDialog(
      map: CustomMap(
        center: center,
        minZoom: 17.0,
        initialZoom: 18.0,
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
    required this.lodges,
  });

  @override
  Widget build(BuildContext context) {
    return MarkerLayerWidget(
      options: MarkerLayerOptions(
        markers: lodges.map((l) => LodgeMarker(lodge: l)).toList(),
      ),
    );
  }
}
