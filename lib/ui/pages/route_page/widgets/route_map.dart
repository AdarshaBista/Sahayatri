import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/place.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_map.dart';
import 'package:sahayatri/ui/pages/route_page/widgets/place_marker.dart';

class RouteMap extends StatelessWidget {
  final List<Place> places;

  const RouteMap({
    @required this.places,
  }) : assert(places != null);

  @override
  Widget build(BuildContext context) {
    final destination = context.bloc<DestinationBloc>().destination;

    return Hero(
      tag: destination.routePoints,
      child: CustomMap(
        center: destination.midPointCoord,
        swPanBoundary: Coord(
          lat: destination.minLat - 0.15,
          lng: destination.minLong - 0.15,
        ),
        nePanBoundary: Coord(
          lat: destination.maxLat + 0.15,
          lng: destination.maxLong + 0.15,
        ),
        markerLayerOptions: _buildMarkers(context),
        polylineLayerOptions: _buildRoute(context),
      ),
    );
  }

  PolylineLayerOptions _buildRoute(BuildContext context) {
    final routePoints = context.bloc<DestinationBloc>().destination.routePoints;

    return PolylineLayerOptions(
      polylines: [
        Polyline(
          strokeWidth: 3.0,
          points: routePoints.map((p) => p.toLatLng()).toList(),
          gradientColors: AppColors.accentColors.getRange(4, 7).toList(),
        ),
      ],
    );
  }

  MarkerLayerOptions _buildMarkers(BuildContext context) {
    return MarkerLayerOptions(
      markers: [
        for (int i = 0; i < places.length; ++i)
          PlaceMarker(
            point: places[i].coord.toLatLng(),
            color: AppColors.accentColors[i % AppColors.accentColors.length],
            onTap: () {
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
