import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/itinerary.dart';

import 'package:provider/provider.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/shared/widgets/custom_map.dart';
import 'package:sahayatri/ui/pages/itinerary_page/widgets/checkpoint_marker.dart';

class ItineraryMap extends StatelessWidget {
  const ItineraryMap();

  @override
  Widget build(BuildContext context) {
    final itinerary = Provider.of<Itinerary>(context);
    final places = itinerary.checkpoints.map((c) => c.place).toList();
    final center = places[places.length ~/ 2].coord;

    return CustomMap(
      center: center,
      markerLayerOptions: _buildMarkers(context),
    );
  }

  MarkerLayerOptions _buildMarkers(BuildContext context) {
    final checkpoints = Provider.of<Itinerary>(context).checkpoints;

    return MarkerLayerOptions(
      markers: checkpoints
          .map(
            (c) => Marker(
              width: 200,
              height: 64,
              anchorPos: AnchorPos.align(AnchorAlign.top),
              point: c.place.coord.toLatLng(),
              builder: (_) => CheckpointMarker(checkpoint: c),
            ),
          )
          .toList(),
    );
  }
}
