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
import 'package:sahayatri/ui/shared/animators/map_animator.dart';
import 'package:sahayatri/ui/shared/widgets/close_icon.dart';
import 'package:sahayatri/ui/shared/widgets/map/layers_button.dart';
import 'package:sahayatri/ui/shared/widgets/map/track_location_button.dart';

class CustomMap extends StatefulWidget {
  final bool trackLocation;
  final Coord center;
  final Coord swPanBoundary;
  final Coord nePanBoundary;
  final double initialZoom;
  final Function(LatLng) onTap;
  final int userIndex;
  final CircleLayerOptions circleLayerOptions;
  final MarkerLayerOptions markerLayerOptions;

  const CustomMap({
    @required this.center,
    this.trackLocation = false,
    this.initialZoom = 12.0,
    this.onTap,
    this.swPanBoundary,
    this.nePanBoundary,
    this.userIndex = 0,
    this.circleLayerOptions,
    this.markerLayerOptions,
  })  : assert(center != null),
        assert(userIndex != null);

  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> with SingleTickerProviderStateMixin {
  bool isTracking;
  MapAnimator mapAnimator;
  MapController mapController;

  @override
  void initState() {
    isTracking = widget.trackLocation;
    mapController = MapController();
    mapAnimator = MapAnimator(mapController: mapController, tickerProvider: this);
    super.initState();
  }

  @override
  void dispose() {
    mapAnimator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildMap(),
        const Positioned(top: 16.0, left: 16.0, child: SafeArea(child: CloseIcon())),
        const Positioned(top: 16.0, right: 16.0, child: SafeArea(child: LayersButton())),
        if (widget.trackLocation)
          Positioned(
            top: 64.0,
            right: 16.0,
            child: SafeArea(
              child: TrackLocationButton(
                isTracking: isTracking,
                onTap: () => isTracking = !isTracking,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMap() {
    return BlocBuilder<PrefsBloc, PrefsState>(
      builder: (context, state) {
        if (widget.trackLocation && isTracking) _trackLocation();
        return FlutterMap(
          mapController: mapController,
          options: MapOptions(
            onTap: widget.onTap,
            minZoom: 10.0,
            maxZoom: 19.0,
            zoom: widget.initialZoom,
            center: widget.center.toLatLng(),
            onPositionChanged: (position, hasGesture) {
              if (hasGesture) isTracking = false;
            },
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
          layers: [
            _buildTiles((state as PrefsLoaded).prefs.mapStyle),
            _buildRoute(context),
            if (widget.circleLayerOptions != null) widget.circleLayerOptions,
            if (widget.markerLayerOptions != null) widget.markerLayerOptions,
          ],
        );
      },
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
    final userPath = routePoints.take(widget.userIndex).toList();
    final remainingPath =
        routePoints.getRange(widget.userIndex + 1, routePoints.length).toList();

    return PolylineLayerOptions(
      polylines: [
        Polyline(
          strokeWidth: 4.0,
          points: remainingPath.map((p) => p.toLatLng()).toList(),
          gradientColors: AppColors.accentColors.take(4).toList(),
        ),
        Polyline(
          strokeWidth: 6.0,
          points: [
            ...userPath.map((p) => p.toLatLng()).toList(),
            widget.center.toLatLng(),
          ],
          gradientColors: AppColors.accentColors.getRange(5, 8).toList(),
        ),
      ],
    );
  }

  void _trackLocation() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapAnimator.move(widget.center.toLatLng());
    });
  }
}
