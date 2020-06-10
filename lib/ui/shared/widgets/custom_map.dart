import 'dart:io';

import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/values.dart';
import 'package:sahayatri/app/constants/api_keys.dart';

import 'package:latlong/latlong.dart';
import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/close_icon.dart';

class CustomMap extends StatefulWidget {
  final Coord center;
  final Coord swPanBoundary;
  final Coord nePanBoundary;
  final Function(LatLng) onTap;
  final MarkerLayerOptions markerLayerOptions;

  const CustomMap({
    @required this.center,
    this.onTap,
    this.swPanBoundary,
    this.nePanBoundary,
    this.markerLayerOptions,
  }) : assert(center != null);

  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> with TickerProviderStateMixin {
  MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            zoom: 12.0,
            minZoom: 10.0,
            maxZoom: 16.0,
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
            _buildTiles(),
            _buildRoute(context),
            if (widget.markerLayerOptions != null) widget.markerLayerOptions,
          ],
        ),
        const Positioned(
          top: 16.0,
          right: 16.0,
          child: SafeArea(child: CloseIcon()),
        ),
      ],
    );
  }

  TileLayerOptions _buildTiles() {
    return TileLayerOptions(
      tileProvider:
          Platform.isWindows ? NetworkTileProvider() : const CachedNetworkTileProvider(),
      backgroundColor: AppColors.background,
      keepBuffer: 8,
      tileSize: 512,
      zoomOffset: -1,
      urlTemplate: Values.kMapUrl,
      additionalOptions: {
        'accessToken': ApiKeys.kMapBoxAccessToken,
        'id': Values.kMapStyle,
      },
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
