import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:sahayatri/core/constants/configs.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/utils/config_reader.dart';

import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/exit_button.dart';
import 'package:sahayatri/ui/widgets/map/menu/menu_button.dart';
import 'package:sahayatri/ui/widgets/map/menu/menu_drawer.dart';
import 'package:sahayatri/ui/widgets/map/route_layer.dart';

class CustomMap extends StatefulWidget {
  final Coord center;
  final double minZoom;
  final double maxZoom;
  final double initialZoom;
  final List<Widget> children;
  final Size? size;
  final Coord? swPanBoundary;
  final Coord? nePanBoundary;
  final void Function(Coord)? onTap;
  final MapController? mapController;
  final void Function(MapPosition, bool)? onPositionChanged;

  const CustomMap({
    super.key,
    required this.center,
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
  });

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = widget.mapController ?? MapController();
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
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        zoom: widget.initialZoom,
        minZoom: widget.minZoom,
        maxZoom: widget.maxZoom,
        screenSize: widget.size,
        center: widget.center.toLatLng(),
        controller: mapController,
        onTap: (_, latLng) =>
            widget.onTap?.call(Coord(lat: latLng.latitude, lng: latLng.longitude)),
        onPositionChanged: widget.onPositionChanged,
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
      children: [
        const _TileLayer(),
        RouteLayer(mapController: mapController),
        ...widget.children,
      ],
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
            tileFadeInDuration: const Duration(milliseconds: 300),
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
