import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/map/custom_map.dart';
import 'package:sahayatri/ui/widgets/dialogs/map_dialog.dart';
import 'package:sahayatri/ui/widgets/map/markers/dynamic_text_marker.dart';

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
    return DynamicTextMarker(
      coord: c,
      shrinkWhen: true,
      color: AppColors.light,
      icon: AppIcons.updateMarker,
      backgroundColor: AppColors.secondary,
    );
  }
}
