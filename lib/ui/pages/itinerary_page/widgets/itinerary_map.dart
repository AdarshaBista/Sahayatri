import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/itinerary.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_map.dart';
import 'package:sahayatri/ui/shared/widgets/place_marker.dart';

class ItineraryMap extends StatelessWidget {
  const ItineraryMap();

  @override
  Widget build(BuildContext context) {
    final itinerary = Provider.of<Itinerary>(context);
    final places = itinerary.checkpoints.map((c) => c.place).toList();
    final center = places[places.length ~/ 2].coord;

    return Hero(
      tag: itinerary.hashCode,
      child: CustomMap(
        center: center,
        markerLayerOptions: _buildMarkers(context, places),
      ),
    );
  }

  MarkerLayerOptions _buildMarkers(BuildContext context, List<Place> places) {
    return MarkerLayerOptions(
      markers: [
        for (int i = 0; i < places.length; ++i)
          PlaceMarker(
            point: places[i].coord.toLatLng(),
            color: AppColors.accentColors[i % AppColors.accentColors.length],
            onTap: () {
              // TODO: Custom pop up
              context.repository<DestinationNavService>().pushNamed(
                    Routes.kPlacePageRoute,
                    arguments: places[i],
                  );
            },
          ),
      ],
    );
  }
}
