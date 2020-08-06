import 'dart:io';

import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';
import 'package:sahayatri/app/constants/api_keys.dart';

import 'package:sahayatri/core/utils/math_utls.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/extensions/coord_list_x.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/prefs_bloc/prefs_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/map/layers_button.dart';
import 'package:sahayatri/ui/shared/widgets/buttons/close_icon.dart';

class CustomMap extends StatefulWidget {
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
    this.onPositionChanged,
    this.children = const [],
    this.initialZoom = MapConfig.kDefaultZoom,
  })  : assert(center != null),
        assert(children != null);

  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  double zoom;

  @override
  void initState() {
    super.initState();
    zoom = widget.initialZoom;
  }

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

  void updateRouteAccuracy(MapPosition pos, bool hasGesture) {
    if (widget.onPositionChanged != null) {
      widget.onPositionChanged(pos, hasGesture);
    }

    if (MathUtils.shouldSimplify(zoom, pos.zoom)) {
      setState(() {
        zoom = pos.zoom;
      });
    }
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: widget.mapController,
      children: [
        const _TileLayer(),
        _RouteLayer(zoom: zoom),
        ...widget.children,
      ],
      options: MapOptions(
        zoom: widget.initialZoom,
        minZoom: MapConfig.kMinZoom,
        maxZoom: MapConfig.kMaxZoom,
        center: widget.center.toLatLng(),
        controller: widget.mapController,
        onPositionChanged: updateRouteAccuracy,
        swPanBoundary: widget.swPanBoundary?.toLatLng() ??
            Coord(
              lat: widget.center.lat - 0.3,
              lng: widget.center.lng - 0.3,
            ).toLatLng(),
        nePanBoundary: widget.nePanBoundary?.toLatLng() ??
            Coord(
              lat: widget.center.lat + 0.3,
              lng: widget.center.lng + 0.3,
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
  final double zoom;

  const _RouteLayer({
    @required this.zoom,
  }) : assert(zoom != null);

  @override
  Widget build(BuildContext context) {
    final route = context.bloc<DestinationBloc>().destination.route;

    return PolylineLayerWidget(
      options: PolylineLayerOptions(
        polylines: [
          Polyline(
            strokeWidth: 5.0,
            gradientColors: AppColors.accentColors.take(4).toList(),
            points: route.simplify(zoom).map((c) => c.toLatLng()).toList(),
          ),
        ],
      ),
    );
  }
}
