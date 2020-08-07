import 'dart:io';

import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/extensions/coord_list_x.dart';

import 'package:sahayatri/app/constants/configs.dart';
import 'package:sahayatri/app/constants/api_keys.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

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
  bool shouldSimplifyRoute = false;

  @override
  void initState() {
    super.initState();
    zoom = widget.initialZoom;
  }

  void onPointerUp() {
    if (shouldSimplifyRoute) {
      setState(() {
        shouldSimplifyRoute = false;
      });
    }
  }

  void onPositionChanged(MapPosition pos, bool hasGesture) {
    if (widget.onPositionChanged != null) {
      widget.onPositionChanged(pos, hasGesture);
    }

    if (zoom != pos.zoom) {
      zoom = pos.zoom;
      shouldSimplifyRoute = true;
    }
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

  Widget _buildMap() {
    return Listener(
      onPointerUp: (_) => onPointerUp(),
      child: FlutterMap(
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
          onPositionChanged: onPositionChanged,
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
    final route = context.bloc<DestinationCubit>().destination.route;

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
