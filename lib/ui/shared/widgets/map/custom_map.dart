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
  final bool showRoute;
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
    this.showRoute = true,
    this.initialZoom = 14.0,
    this.onPositionChanged,
    this.children = const [],
  })  : assert(center != null),
        assert(children != null),
        assert(showRoute != null);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RepaintBoundary(child: _buildMap()),
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
        if (showRoute) const _RouteLayer(),
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
  const _RouteLayer();

  @override
  Widget build(BuildContext context) {
    final route = context.bloc<DestinationBloc>().destination.route;

    return PolylineLayerWidget(
      options: PolylineLayerOptions(
        polylines: [
          Polyline(
            strokeWidth: 6.0,
            points: route.map((p) => p.toLatLng()).toList(),
            gradientColors: AppColors.accentColors.take(4).toList(),
          ),
        ],
      ),
    );
  }
}
