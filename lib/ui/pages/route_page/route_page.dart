import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/places_cubit/places_cubit.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/map/custom_map.dart';
import 'package:sahayatri/ui/widgets/buttons/mini_fab.dart';
import 'package:sahayatri/ui/widgets/map/markers/place_marker.dart';
import 'package:sahayatri/ui/widgets/map/markers/dynamic_text_marker.dart';
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
          icon: AppIcons.altitude,
          onTap: () => _openAltitudeSheet(context),
        ),
      ),
      body: CustomMap(
        center: destination.midPointCoord,
        children: [
          const _PlaceMarkersLayer(),
          if (isSheetOpen) _AltitudeMarkerLayer(index: altitudeDragCoordIndex),
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
          DynamicTextMarker(
            shrinkWhen: false,
            color: AppColors.light,
            icon: AppIcons.mountain,
            coord: destination.route[index],
            backgroundColor: Colors.deepPurple,
            label: '${destination.route[index].alt} m',
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
                    markers: destination.places.reversed
                        .map((p) => PlaceMarker(
                              place: p,
                              shrinkWhen: false,
                            ))
                        .toList()),
              );
            }
            return const Offstage();
          },
        );
      },
    );
  }
}
