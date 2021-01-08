import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/itinerary.dart';

import 'package:provider/provider.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/widgets/map/custom_map.dart';
import 'package:sahayatri/ui/widgets/map/markers/checkpoint_detail_marker.dart';

class ItineraryMap extends StatelessWidget {
  const ItineraryMap();

  @override
  Widget build(BuildContext context) {
    final itinerary = Provider.of<Itinerary>(context, listen: false);
    final places = itinerary.checkpoints.map((c) => c.place).toList();
    final center = places[places.length ~/ 2].coord;

    return CustomMap(
      center: center,
      children: [_buildMarkers(context)],
    );
  }

  Widget _buildMarkers(BuildContext context) {
    final checkpoints = Provider.of<Itinerary>(context, listen: false).checkpoints;
    return MarkerLayerWidget(
      options: MarkerLayerOptions(
        markers: checkpoints.reversed
            .map((c) => CheckpointDetailMarker(checkpoint: c))
            .toList(),
      ),
    );
  }
}
