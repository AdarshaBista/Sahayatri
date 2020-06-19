import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/app/extensions/widget_x.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/map/custom_map.dart';
import 'package:sahayatri/ui/shared/widgets/map/place_marker.dart';
import 'package:sahayatri/ui/shared/widgets/map/altitude_graph.dart';

class RoutePage extends StatelessWidget {
  const RoutePage();

  @override
  Widget build(BuildContext context) {
    final destination = context.bloc<DestinationBloc>().destination;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(CommunityMaterialIcons.chart_bell_curve),
        onPressed: () => AltitudeGraph(
          altitudes: destination.routePoints.map((r) => r.alt).toList(),
        ).openModalBottomSheet(context),
      ),
      body: CustomMap(
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
      ),
    );
  }

  MarkerLayerOptions _buildMarkers(BuildContext context) {
    final places = context.bloc<DestinationBloc>().destination.places;

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
