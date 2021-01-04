import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/places_cubit/places_cubit.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/widgets/map/custom_map.dart';
import 'package:sahayatri/ui/widgets/map/text_marker.dart';
import 'package:sahayatri/ui/widgets/buttons/mini_fab.dart';
import 'package:sahayatri/ui/widgets/map/place_marker.dart';
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
    final destination = context.watch<Destination>();

    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) => MiniFab(
          icon: CommunityMaterialIcons.chart_bell_curve,
          onTap: () => _openAltitudeSheet(context),
        ),
      ),
      body: CustomMap(
        center: destination.midPointCoord,
        children: [
          if (isSheetOpen) _AltitudeMarkerLayer(index: altitudeDragCoordIndex),
          const _PlaceMarkersLayer(zoom: MapConfig.maxZoom),
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
    final destination = context.read<Destination>();

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
    final destination = context.watch<Destination>();

    return MarkerLayerWidget(
      options: MarkerLayerOptions(
        markers: [
          TextMarker(
            color: Colors.blue,
            coord: destination.route[index],
            text: '${destination.route[index].alt} m',
          ),
        ],
      ),
    );
  }
}

class _PlaceMarkersLayer extends StatelessWidget {
  final double zoom;

  const _PlaceMarkersLayer({
    @required this.zoom,
  }) : assert(zoom != null);

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = BlocProvider.of<UserCubit>(context).user != null;
    if (!isAuthenticated) return const Offstage();

    final destination = context.watch<Destination>();
    return BlocBuilder<PrefsCubit, PrefsState>(
      buildWhen: (p, c) => p.prefs.mapLayers.places != c.prefs.mapLayers.places,
      builder: (context, state) {
        final enabled = state.prefs.mapLayers.places;
        if (!enabled) return const Offstage();

        return BlocBuilder<PlacesCubit, PlacesState>(
          builder: (context, state) {
            if (state is PlacesLoaded) {
              return MarkerLayerWidget(
                options: MarkerLayerOptions(
                  markers: [
                    for (int i = 0; i < destination.places.length; ++i)
                      PlaceMarker(
                        place: destination.places[i],
                        hideText: zoom < MapConfig.markerZoomThreshold,
                      ),
                  ],
                ),
              );
            }
            return const Offstage();
          },
        );
      },
    );
  }
}
