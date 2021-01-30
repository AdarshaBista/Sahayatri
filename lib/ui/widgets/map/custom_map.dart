import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/constants/configs.dart';
import 'package:sahayatri/core/utils/config_reader.dart';
import 'package:sahayatri/core/extensions/route_extension.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';

import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/exit_button.dart';
import 'package:sahayatri/ui/widgets/map/menu/menu_drawer.dart';
import 'package:sahayatri/ui/widgets/map/menu/menu_button.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class CustomMap extends StatefulWidget {
  final Size size;
  final Coord center;
  final Coord swPanBoundary;
  final Coord nePanBoundary;
  final double minZoom;
  final double maxZoom;
  final double initialZoom;
  final List<Widget> children;
  final Function(Coord) onTap;
  final MapController mapController;
  final Function(MapPosition, bool) onPositionChanged;

  const CustomMap({
    @required this.center,
    this.size,
    this.onTap,
    this.mapController,
    this.swPanBoundary,
    this.nePanBoundary,
    this.onPositionChanged,
    this.children = const [],
    this.minZoom = MapConfig.minZoom,
    this.maxZoom = MapConfig.maxZoom,
    this.initialZoom = MapConfig.defaultZoom,
  })  : assert(center != null),
        assert(minZoom != null),
        assert(maxZoom != null),
        assert(initialZoom != null),
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

  void onTap(LatLng latLng) {
    if (widget.onTap == null) return;
    widget.onTap(Coord(lat: latLng.latitude, lng: latLng.longitude));
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
    return Scaffold(
      drawer: const MenuDrawer(),
      resizeToAvoidBottomInset: false,
      drawerEnableOpenDragGesture: false,
      drawerScrimColor: AppColors.darkFaded,
      body: Stack(
        children: [
          RepaintBoundary(child: _buildMap()),
          const Positioned(
            top: 16.0,
            right: 16.0,
            child: SafeArea(child: ExitButton()),
          ),
          const Positioned(
            top: 16.0,
            left: 16.0,
            child: SafeArea(child: MenuButton()),
          ),
        ],
      ),
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
          interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          zoom: widget.initialZoom,
          minZoom: widget.minZoom,
          maxZoom: widget.maxZoom,
          screenSize: widget.size,
          center: widget.center.toLatLng(),
          controller: widget.mapController,
          onTap: onTap,
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
    return BlocBuilder<PrefsCubit, PrefsState>(
      buildWhen: (p, c) => p.prefs.mapStyle != c.prefs.mapStyle,
      builder: (context, state) {
        final layerId = state.prefs.mapStyle;

        return TileLayerWidget(
          options: TileLayerOptions(
            backgroundColor: context.c.background,
            keepBuffer: 8,
            tileSize: 512,
            zoomOffset: -1,
            tileFadeInDuration: 300,
            overrideTilesWhenUrlChanges: true,
            urlTemplate:
                'https://api.mapbox.com/styles/v1/{layerId}/tiles/{z}/{x}/{y}@2x?access_token={accessToken}',
            additionalOptions: {
              'layerId': layerId,
              'accessToken': ConfigReader.mapBoxAccessToken,
            },
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
    final destination = context.watch<Destination>();

    return BlocBuilder<PrefsCubit, PrefsState>(
      buildWhen: (p, c) => p.prefs.mapLayers.route != c.prefs.mapLayers.route,
      builder: (context, state) {
        final enabled = state.prefs.mapLayers.route;
        if (!enabled) return const Offstage();

        return ScaleAnimator(
          child: PolylineLayerWidget(
            options: PolylineLayerOptions(
              polylines: [
                Polyline(
                  strokeWidth: 4.0,
                  gradientColors: AppColors.routeGradient,
                  points: destination.route
                      .simplify(zoom)
                      .map((c) => c.toLatLng())
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
