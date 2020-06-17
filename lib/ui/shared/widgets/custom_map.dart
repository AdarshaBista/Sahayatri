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
import 'package:sahayatri/ui/shared/widgets/track_location_button.dart';

class CustomMap extends StatefulWidget {
  final bool trackLocation;
  final Coord center;
  final Coord swPanBoundary;
  final Coord nePanBoundary;
  final Function(LatLng) onTap;
  final CircleLayerOptions circleLayerOptions;
  final MarkerLayerOptions markerLayerOptions;

  const CustomMap({
    @required this.center,
    this.trackLocation = false,
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
  bool isTracking = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<PrefsBloc, PrefsState>(
          builder: (context, state) {
            if (widget.trackLocation && isTracking) _trackLocation();

            return FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                zoom: 12.0,
                minZoom: 10.0,
                maxZoom: 19.0,
                center: widget.center.toLatLng(),
                onTap: widget.onTap,
                onPositionChanged: (position, hasGesture) {
                  if (hasGesture) isTracking = false;
                },
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
        if (widget.trackLocation)
          Positioned(
            top: 64.0,
            right: 16.0,
            child: SafeArea(
              child: TrackLocationButton(
                isTracking: isTracking,
                onTap: () {
                  isTracking = !isTracking;
                  _animateMapTo(widget.center.toLatLng());
                },
              ),
            ),
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

  void _trackLocation() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animateMapTo(widget.center.toLatLng());
    });
  }

  void _animateMapTo(LatLng destination) {
    if (destination == null) return;

    final _latTween = Tween<double>(
      begin: _mapController.center.latitude,
      end: destination.latitude,
    );
    final _lngTween = Tween<double>(
      begin: _mapController.center.longitude,
      end: destination.longitude,
    );
    final _zoomTween = Tween<double>(
      begin: _mapController.zoom,
      end: 18.0,
    );

    final AnimationController animController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    final Animation<double> animation = CurvedAnimation(
      parent: animController,
      curve: Curves.fastOutSlowIn,
    );

    animController.addListener(() {
      _mapController.move(
        LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
        _zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animController.dispose();
      } else if (status == AnimationStatus.dismissed) {
        animController.dispose();
      }
    });
    animController.forward();
  }
}
