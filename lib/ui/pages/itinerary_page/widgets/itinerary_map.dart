import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/checkpoint.dart';

import 'package:provider/provider.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_map.dart';
import 'package:sahayatri/ui/shared/widgets/place_marker.dart';
import 'package:sahayatri/ui/pages/itinerary_page/widgets/checkpoint_marker.dart';

class ItineraryMap extends StatefulWidget {
  const ItineraryMap();

  @override
  _ItineraryMapState createState() => _ItineraryMapState();
}

class _ItineraryMapState extends State<ItineraryMap> {
  Checkpoint tappedCheckpoint;

  @override
  Widget build(BuildContext context) {
    final itinerary = Provider.of<Itinerary>(context);
    final places = itinerary.checkpoints.map((c) => c.place).toList();
    final center = places[places.length ~/ 2].coord;

    return CustomMap(
      center: center,
      markerLayerOptions: _buildMarkers(context),
      onTap: (_) => setState(() {
        tappedCheckpoint = null;
      }),
    );
  }

  MarkerLayerOptions _buildMarkers(BuildContext context) {
    final checkpoints = Provider.of<Itinerary>(context).checkpoints;

    return MarkerLayerOptions(
      markers: [
        for (int i = 0; i < checkpoints.length; ++i)
          PlaceMarker(
            point: checkpoints[i].place.coord.toLatLng(),
            color: checkpoints[i] == tappedCheckpoint
                ? AppColors.background
                : AppColors.accentColors[i % AppColors.accentColors.length],
            onTap: () {
              setState(() {
                tappedCheckpoint = checkpoints[i];
              });
            },
          ),
        if (tappedCheckpoint != null)
          Marker(
            width: 200,
            height: 64,
            anchorPos: AnchorPos.align(AnchorAlign.top),
            point: tappedCheckpoint.place.coord.toLatLng(),
            builder: (_) => CheckpointMarker(checkpoint: tappedCheckpoint),
          ),
      ],
    );
  }
}
