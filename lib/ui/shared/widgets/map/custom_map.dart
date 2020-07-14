import 'dart:io';

import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/api_keys.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/prefs_bloc/prefs_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/map/layers_button.dart';
import 'package:sahayatri/ui/shared/widgets/buttons/close_icon.dart';

class CustomMap extends StatelessWidget {
  final int userIndex;
  final Coord center;
  final Coord swPanBoundary;
  final Coord nePanBoundary;
  final double initialZoom;
  final List<Widget> children;
  final MapController mapController;
  final Function(MapPosition, bool) onPositionChanged;

  const CustomMap({
    @required this.center,
    this.mapController,
    this.swPanBoundary,
    this.nePanBoundary,
    this.userIndex = 0,
    this.initialZoom = 14.0,
    this.onPositionChanged,
    this.children = const [],
  })  : assert(center != null),
        assert(children != null),
        assert(userIndex != null);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildMap(),
        const Positioned(top: 16.0, left: 16.0, child: SafeArea(child: CloseIcon())),
        const Positioned(top: 16.0, right: 16.0, child: SafeArea(child: LayersButton())),
      ],
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: mapController,
      children: [
        const _TileLayer(),
        _RouteLayer(userCoord: center, userIndex: userIndex),
        ...children,
      ],
      options: MapOptions(
        minZoom: 10.0,
        maxZoom: 19.0,
        zoom: initialZoom,
        center: center.toLatLng(),
        controller: mapController,
        onPositionChanged: onPositionChanged,
        swPanBoundary: swPanBoundary?.toLatLng() ??
            Coord(
              lat: center.lat - 0.3,
              lng: center.lng - 0.3,
            ).toLatLng(),
        nePanBoundary: nePanBoundary?.toLatLng() ??
            Coord(
              lat: center.lat + 0.3,
              lng: center.lng + 0.3,
            ).toLatLng(),
      ),
    );
  }
}

class _TileLayer extends StatelessWidget {
  const _TileLayer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrefsBloc, PrefsState>(
      builder: (context, state) {
        final layerId = (state as PrefsLoaded).prefs.mapStyle;

        return TileLayerWidget(
          options: TileLayerOptions(
            backgroundColor: AppColors.light,
            tileProvider: Platform.isWindows
                ? NetworkTileProvider()
                : const CachedNetworkTileProvider(),
            keepBuffer: 8,
            tileSize: 512,
            zoomOffset: -1,
            tileFadeInDuration: 300,
            overrideTilesWhenUrlChanges: true,
            urlTemplate:
                'https://api.mapbox.com/styles/v1/$layerId/tiles/{z}/{x}/{y}@2x?access_token=${ApiKeys.kMapBoxAccessToken}',
          ),
        );
      },
    );
  }
}

class _RouteLayer extends StatelessWidget {
  final int userIndex;
  final Coord userCoord;

  const _RouteLayer({
    @required this.userIndex,
    @required this.userCoord,
  })  : assert(userIndex != null),
        assert(userCoord != null);

  @override
  Widget build(BuildContext context) {
    final route = context.bloc<DestinationBloc>().destination.route;
    final userPath = route.take(userIndex).toList();
    final remainingStartIndex = userIndex > 0 ? userIndex - 1 : 0;
    final remainingPath = route.getRange(remainingStartIndex, route.length).toList();

    return PolylineLayerWidget(
      options: PolylineLayerOptions(
        polylines: [
          Polyline(
            strokeWidth: 6.0,
            points: remainingPath.map((p) => p.toLatLng()).toList(),
            gradientColors: AppColors.accentColors.take(4).toList(),
          ),
          Polyline(
            strokeWidth: 6.0,
            points: [
              ...userPath.map((p) => p.toLatLng()).toList(),
              userCoord.toLatLng(),
            ],
            gradientColors: AppColors.accentColors.getRange(5, 8).toList(),
          ),
        ],
      ),
    );
  }
}
