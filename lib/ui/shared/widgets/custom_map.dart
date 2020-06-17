import 'dart:io';

import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/api_keys.dart';

import 'package:latlong/latlong.dart';
import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/prefs_bloc/prefs_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/close_icon.dart';
import 'package:sahayatri/ui/shared/widgets/layers_button.dart';

class CustomMap extends StatefulWidget {
  final Coord center;
  final Coord swPanBoundary;
  final Coord nePanBoundary;
  final Function(LatLng) onTap;
  final CircleLayerOptions circleLayerOptions;
  final MarkerLayerOptions markerLayerOptions;

  const CustomMap({
    @required this.center,
    this.onTap,
    this.swPanBoundary,
    this.nePanBoundary,
    this.circleLayerOptions,
    this.markerLayerOptions,
  }) : assert(center != null);

  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> with TickerProviderStateMixin {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<PrefsBloc, PrefsState>(
          builder: (context, state) {
            return FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                zoom: 12.0,
                minZoom: 10.0,
                maxZoom: 18.0,
                onTap: widget.onTap,
                center: widget.center.toLatLng(),
                swPanBoundary: widget.swPanBoundary?.toLatLng() ??
                    Coord(
                      lat: widget.center.lat - 1.0,
                      lng: widget.center.lng - 1.0,
                    ).toLatLng(),
                nePanBoundary: widget.nePanBoundary?.toLatLng() ??
                    Coord(
                      lat: widget.center.lat + 1.0,
                      lng: widget.center.lng + 1.0,
                    ).toLatLng(),
              ),
              layers: [
                _buildTiles(state.prefs.mapStyle),
                _buildRoute(context),
                if (widget.circleLayerOptions != null) widget.circleLayerOptions,
                if (widget.markerLayerOptions != null) widget.markerLayerOptions,
              ],
            );
          },
        ),
        const Positioned(
          top: 16.0,
          left: 16.0,
          child: SafeArea(child: CloseIcon()),
        ),
        const Positioned(
          top: 16.0,
          right: 16.0,
          child: SafeArea(child: LayersButton()),
        ),
      ],
    );
  }

  TileLayerOptions _buildTiles(String layerId) {
    return TileLayerOptions(
      tileProvider:
          Platform.isWindows ? NetworkTileProvider() : const CachedNetworkTileProvider(),
      backgroundColor: AppColors.background,
      keepBuffer: 8,
      tileSize: 512,
      zoomOffset: -1,
      tileFadeInDuration: 300,
      overrideTilesWhenUrlChanges: true,
      urlTemplate:
          'https://api.mapbox.com/styles/v1/$layerId/tiles/{z}/{x}/{y}@2x?access_token=${ApiKeys.kMapBoxAccessToken}',
    );
  }

  PolylineLayerOptions _buildRoute(BuildContext context) {
    final routePoints = context.bloc<DestinationBloc>().destination.routePoints;

    return PolylineLayerOptions(
      polylines: [
        Polyline(
          strokeWidth: 3.0,
          points: routePoints.map((p) => p.toLatLng()).toList(),
          gradientColors: AppColors.accentColors.getRange(4, 7).toList(),
        ),
      ],
    );
  }
}
