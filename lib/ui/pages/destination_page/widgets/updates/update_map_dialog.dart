import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/map/custom_map.dart';
import 'package:sahayatri/ui/widgets/dialogs/map_dialog.dart';

class UpdateMapDialog extends StatelessWidget {
  final List<Coord> coords;

  const UpdateMapDialog({
    @required this.coords,
  }) : assert(coords != null);

  @override
  Widget build(BuildContext context) {
    return MapDialog(
      map: CustomMap(
        initialZoom: 17.0,
        center: coords.first,
        children: [_MarkersLayer(coords: coords)],
      ),
    );
  }
}

class _MarkersLayer extends StatelessWidget {
  final List<Coord> coords;

  const _MarkersLayer({
    @required this.coords,
  }) : assert(coords != null);

  @override
  Widget build(BuildContext context) {
    return MarkerLayerWidget(
      options: MarkerLayerOptions(
        markers: coords.map((c) => _buildMarker(c)).toList(),
      ),
    );
  }

  Marker _buildMarker(Coord c) {
    const double size = 24.0;

    return Marker(
      width: size,
      height: size,
      point: c.toLatLng(),
      builder: (context) {
        return const Icon(
          CommunityMaterialIcons.circle_double,
          size: size,
          color: AppColors.secondary,
        );
      },
    );
  }
}
