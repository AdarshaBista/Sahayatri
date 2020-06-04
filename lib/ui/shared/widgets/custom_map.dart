import 'dart:io';

import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/api_keys.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';

class CustomMap extends StatefulWidget {
  final Coord center;
  final Coord swPanBoundary;
  final Coord nePanBoundary;
  final MarkerLayerOptions markerLayerOptions;
  final PolylineLayerOptions polylineLayerOptions;

  const CustomMap({
    @required this.center,
    this.swPanBoundary,
    this.nePanBoundary,
    this.markerLayerOptions,
    this.polylineLayerOptions,
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
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        zoom: 12.0,
        minZoom: 10.0,
        maxZoom: 16.0,
        interactive: true,
        center: widget.center.toLatLng(),
        swPanBoundary: widget.swPanBoundary.toLatLng(),
        nePanBoundary: widget.nePanBoundary.toLatLng(),
      ),
      layers: [
        _buildTiles(),
        if (widget.polylineLayerOptions != null) widget.polylineLayerOptions,
        if (widget.markerLayerOptions != null) widget.markerLayerOptions,
      ],
    );
  }

  TileLayerOptions _buildTiles() {
    return TileLayerOptions(
      tileProvider: Platform.isWindows
          ? NetworkTileProvider()
          : const CachedNetworkTileProvider(),
      backgroundColor: AppColors.background,
      keepBuffer: 8,
      tileSize: 512,
      zoomOffset: -1,
      urlTemplate:
          "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}@2x?access_token={accessToken}",
      additionalOptions: {
        'accessToken': kMapBoxAccessToken,
        'id': 'mapbox/outdoors-v11',
      },
    );
  }
}
