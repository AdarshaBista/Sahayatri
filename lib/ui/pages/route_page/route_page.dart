import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
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
    final destination = context.bloc<DestinationCubit>().destination;

    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: const Icon(CommunityMaterialIcons.chart_bell_curve),
          onPressed: () => _openAltitudeSheet(context),
        ),
      ),
      body: CustomMap(
        center: destination.midPointCoord,
        children: [
          if (isSheetOpen) _AltitudeMarkerLayer(index: altitudeDragCoordIndex),
          const _PlaceMarkersLayer()
        ],
        swPanBoundary: Coord(
          lat: destination.minLat - 0.15,
          lng: destination.minLong - 0.15,
        ),
        nePanBoundary: Coord(
          lat: destination.maxLat + 0.15,
          lng: destination.maxLong + 0.15,
        ),
      ),
    );
  }

  Future<void> _openAltitudeSheet(BuildContext context) async {
    final destination = context.bloc<DestinationCubit>().destination;

    setState(() {
      isSheetOpen = !isSheetOpen;
    });

    if (isSheetOpen) {
      final bsController = AltitudeGraph(
        altitudes: destination.route.map((p) => p.alt).toList(),
        routeLengthKm: double.parse(destination.length),
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
      Navigator.of(context).pop();
    }
  }
}

class _AltitudeMarkerLayer extends StatelessWidget {
  final int index;

  const _AltitudeMarkerLayer({
    @required this.index,
  }) : assert(index != null);

  @override
  Widget build(BuildContext context) {
    final destination = context.bloc<DestinationCubit>().destination;

    return MarkerLayerWidget(
      options: MarkerLayerOptions(
        markers: [
          Marker(
            width: 32.0,
            height: 32.0,
            point: destination.route[index].toLatLng(),
            anchorPos: AnchorPos.align(AnchorAlign.top),
            builder: (context) {
              return const Icon(
                CommunityMaterialIcons.map_marker,
                size: 32.0,
                color: AppColors.secondary,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PlaceMarkersLayer extends StatelessWidget {
  const _PlaceMarkersLayer();

  @override
  Widget build(BuildContext context) {
    final destination = context.bloc<DestinationCubit>().destination;

    return MarkerLayerWidget(
      options: MarkerLayerOptions(
        markers: [
          for (int i = 0; i < destination.places.length; ++i)
            PlaceMarker(
              place: destination.places[i],
              color: AppColors.accentColors[i % AppColors.accentColors.length],
            ),
        ],
      ),
    );
  }
}
