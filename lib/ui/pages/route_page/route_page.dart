import 'package:flutter/material.dart';

import 'package:sahayatri/app/extensions/widget_x.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/widgets/map/custom_map.dart';
import 'package:sahayatri/ui/shared/widgets/map/place_marker.dart';
import 'package:sahayatri/ui/pages/route_page/widgets/altitude_graph.dart';

class RoutePage extends StatefulWidget {
  const RoutePage();

  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  bool isSheetOpen = false;
  int altitudeDragCoordIndex = 0;

  @override
  Widget build(BuildContext context) {
    final destination = context.bloc<DestinationBloc>().destination;

    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: const Icon(CommunityMaterialIcons.chart_bell_curve),
          onPressed: () => _openAltitudeSheet(context),
        ),
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

  Future<void> _openAltitudeSheet(BuildContext context) async {
    final destination = context.bloc<DestinationBloc>().destination;

    setState(() {
      isSheetOpen = !isSheetOpen;
    });

    if (isSheetOpen) {
      final bsController = AltitudeGraph(
        altitudes: destination.route.map((p) => p.alt).toList(),
        onDrag: (index) {
          setState(() {
            altitudeDragCoordIndex = index;
          });
        },
      ).openBottomSheet(context);

      await bsController.closed;
      setState(() {
        isSheetOpen = false;
      });
    } else {
      context.repository<DestinationNavService>().pop();
    }
  }

  MarkerLayerOptions _buildMarkers(BuildContext context) {
    final destination = context.bloc<DestinationBloc>().destination;

    return MarkerLayerOptions(
      markers: [
        for (int i = 0; i < destination.places.length; ++i)
          PlaceMarker(
            place: destination.places[i],
            color: AppColors.accentColors[i % AppColors.accentColors.length],
          ),
        if (isSheetOpen)
          Marker(
            width: 32.0,
            height: 32.0,
            point: destination.route[altitudeDragCoordIndex].toLatLng(),
            anchorPos: AnchorPos.align(AnchorAlign.top),
            builder: (context) {
              return const Icon(
                Icons.location_on,
                size: 32.0,
                color: AppColors.dark,
              );
            },
          ),
      ],
    );
  }
}
