import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/values.dart';
import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/map/custom_map.dart';
import 'package:sahayatri/ui/shared/widgets/map/place_marker.dart';

class TrackerMap extends StatelessWidget {
  final int userIndex;
  final UserLocation userLocation;

  const TrackerMap({
    @required this.userIndex,
    @required this.userLocation,
  })  : assert(userIndex != null),
        assert(userLocation != null);

  @override
  Widget build(BuildContext context) {
    final Coord center = userLocation.coord;

    return CustomMap(
      center: center,
      initialZoom: 18.0,
      trackLocation: true,
      polyline: _getUserPolyline(context),
      markerLayerOptions: _buildMarkers(context, center),
      circleLayerOptions: _buildAccuracyCircle(center),
    );
  }

  Polyline _getUserPolyline(BuildContext context) {
    final route = context.bloc<DestinationBloc>().destination.routePoints;

    return Polyline(
      strokeWidth: 6.0,
      color: AppColors.primary,
      points: [
        ...route.take(userIndex).map((p) => p.toLatLng()).toList(),
        userLocation.coord.toLatLng(),
      ],
    );
  }

  MarkerLayerOptions _buildMarkers(BuildContext context, Coord center) {
    final destination = context.bloc<DestinationBloc>().destination;

    return MarkerLayerOptions(
      markers: [
        for (int i = 0; i < destination.places.length; ++i)
          PlaceMarker(
            point: destination.places[i].coord.toLatLng(),
            color: AppColors.accentColors[i % AppColors.accentColors.length],
            onTap: () {
              context.repository<DestinationNavService>().pushNamed(
                    Routes.kPlacePageRoute,
                    arguments: destination.places[i],
                  );
            },
          ),
        Marker(
          width: 24.0,
          height: 24.0,
          point: center.toLatLng(),
          builder: (context) => Transform.rotate(
            angle: userLocation.bearing,
            child: Image.asset(
              Values.kUserMarkerImage,
              width: 26.0,
              height: 26.0,
            ),
          ),
        ),
      ],
    );
  }

  CircleLayerOptions _buildAccuracyCircle(Coord center) {
    return CircleLayerOptions(
      circles: [
        CircleMarker(
          point: center.toLatLng(),
          borderStrokeWidth: 2.0,
          color: Colors.teal.withOpacity(0.2),
          borderColor: Colors.teal.withOpacity(0.5),
          useRadiusInMeter: true,
          radius: userLocation.accuracy,
        ),
      ],
    );
  }
}
