import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import 'package:sahayatri/core/constants/configs.dart';
import 'package:sahayatri/core/extensions/route_extension.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/user_itinerary_cubit/user_itinerary_cubit.dart';

import 'package:sahayatri/ui/pages/tracker_page/widgets/map/accuracy_circle.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/checkpoint_marker.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/device_marker.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/track_location_button.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/user_location_layer.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/user_marker.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/map_animator.dart';
import 'package:sahayatri/ui/widgets/map/custom_map.dart';
import 'package:sahayatri/ui/widgets/map/markers/checkpoint_detail_marker.dart';
import 'package:sahayatri/ui/widgets/map/markers/place_marker.dart';

class TrackerMap extends StatefulWidget {
  const TrackerMap({super.key});

  @override
  State<TrackerMap> createState() => _TrackerMapState();
}

class _TrackerMapState extends State<TrackerMap>
    with SingleTickerProviderStateMixin {
  bool isTracking = true;
  late double zoom;
  late final MapAnimator mapAnimator;
  late final MapController mapController;

  @override
  void initState() {
    zoom = 18.0;
    mapController = MapController();
    mapAnimator = MapAnimator(
      tickerProvider: this,
      mapController: mapController,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    mapAnimator.dispose();
    super.dispose();
  }

  void onPositionChanged(MapPosition pos, bool hasGesture) {
    if (hasGesture && isTracking) {
      setState(() {
        isTracking = false;
      });
    }

    if (zoom != pos.zoom) zoom = pos.zoom ?? 18.0;
  }

  @override
  Widget build(BuildContext context) {
    final center = context.watch<TrackerUpdate>().currentLocation.coord;

    if (isTracking) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mapAnimator.move(center.toLatLng());
      });
    }

    return Stack(
      children: [
        _buildMap(center),
        _buildTrackLocationButton(),
      ],
    );
  }

  Widget _buildMap(Coord center) {
    return Provider<double>.value(
      value: zoom,
      child: CustomMap(
        center: center,
        initialZoom: zoom,
        mapController: mapController,
        onPositionChanged: onPositionChanged,
        children: const [
          _UserTrackLayer(),
          _DevicesAccuracyCircleLayer(),
          _UserAccuracyCircleLayer(),
          _UserMarkerLayer(),
          _CheckpointsPlacesMarkersLayer(),
          _DevicesMarkersLayer(),
        ],
      ),
    );
  }

  Widget _buildTrackLocationButton() {
    return Positioned(
      top: 64.0,
      right: 16.0,
      child: SafeArea(
        child: TrackLocationButton(
          isTracking: isTracking,
          onTap: () => setState(() {
            isTracking = !isTracking;
          }),
        ),
      ),
    );
  }
}

class _UserTrackLayer extends StatelessWidget {
  const _UserTrackLayer();

  @override
  Widget build(BuildContext context) {
    final zoom = context.watch<double>();
    final trackerUpdate = context.watch<TrackerUpdate>();

    final userPath = trackerUpdate.userTrack.map((t) => t.coord).toList();
    final simplifiedPath =
        userPath.simplify(zoom).map((p) => p.toLatLng()).toList()..removeLast();

    final trackGradientColors = trackerUpdate.isOffRoute
        ? AppColors.userTrackOffRouteGradient
        : AppColors.userTrackGradient;

    return UserLocationLayer(
      builder: (point) => PolylineLayerWidget(
        options: PolylineLayerOptions(
          polylines: [
            Polyline(
              strokeWidth: 6.0,
              gradientColors: trackGradientColors,
              points: [...simplifiedPath, point],
            ),
          ],
        ),
      ),
    );
  }
}

class _UserAccuracyCircleLayer extends StatelessWidget {
  const _UserAccuracyCircleLayer();

  @override
  Widget build(BuildContext context) {
    final currentLocation = context.watch<TrackerUpdate>().currentLocation;

    return UserLocationLayer(
      builder: (point) => CircleLayerWidget(
        options: CircleLayerOptions(
          circles: [
            AccuracyCircle(
              point: point,
              color: AppColors.primaryDark,
              radius: currentLocation.accuracy,
            ),
          ],
        ),
      ),
    );
  }
}

class _DevicesAccuracyCircleLayer extends StatelessWidget {
  const _DevicesAccuracyCircleLayer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrefsCubit, PrefsState>(
      buildWhen: (p, c) =>
          p.prefs.mapLayers.nearbyDevices != c.prefs.mapLayers.nearbyDevices,
      builder: (context, state) {
        final enabled = state.prefs.mapLayers.nearbyDevices;
        if (!enabled) return const SizedBox();

        return BlocBuilder<NearbyCubit, NearbyState>(
          builder: (context, state) {
            if (state is NearbyConnected) {
              return CircleLayerWidget(
                options: CircleLayerOptions(
                  circles: state.trackingDevices
                      .map(
                        (d) => AccuracyCircle(
                          color: Colors.blue,
                          radius: d.userLocation!.accuracy,
                          point: d.userLocation!.coord.toLatLng(),
                        ),
                      )
                      .toList(),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }
}

class _CheckpointsPlacesMarkersLayer extends StatelessWidget {
  const _CheckpointsPlacesMarkersLayer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrefsCubit, PrefsState>(
      buildWhen: (p, c) =>
          p.prefs.mapLayers.places != c.prefs.mapLayers.places ||
          p.prefs.mapLayers.checkpoints != c.prefs.mapLayers.checkpoints,
      builder: (context, state) {
        final zoom = context.watch<double>();

        final placesEnabled = state.prefs.mapLayers.places;
        final checkpointsEnabled = state.prefs.mapLayers.checkpoints;
        if (!placesEnabled && !checkpointsEnabled) return const SizedBox();

        final List<Place> places = [];
        final List<Marker> markers = [];

        if (placesEnabled) {
          final destination = context.watch<Destination>();
          places.addAll(destination.places!);
        }

        if (checkpointsEnabled) {
          final itinerary =
              BlocProvider.of<UserItineraryCubit>(context).userItinerary;
          markers.addAll(itinerary.checkpoints.map(
            (c) {
              if (zoom < MapConfig.markerZoomThreshold) {
                return CheckpointMarker(checkpoint: c);
              }
              return CheckpointDetailMarker(checkpoint: c, isTracking: true);
            },
          ));

          if (placesEnabled) {
            final checkpointPlaces =
                itinerary.checkpoints.map((c) => c.place).toList();
            places.removeWhere((p) => checkpointPlaces.contains(p));
          }
        }

        markers.addAll(places.map(
          (p) => PlaceMarker(
            place: p,
            shrinkWhen: zoom < MapConfig.markerZoomThreshold,
          ),
        ));

        return MarkerLayerWidget(
          options: MarkerLayerOptions(
            markers: markers.reversed.toList(),
          ),
        );
      },
    );
  }
}

class _UserMarkerLayer extends StatelessWidget {
  const _UserMarkerLayer();

  @override
  Widget build(BuildContext context) {
    return UserLocationLayer(
      repaintBoundary: true,
      builder: (point) => MarkerLayerWidget(
        options: MarkerLayerOptions(
          markers: [UserMarker(point: point)],
        ),
      ),
    );
  }
}

class _DevicesMarkersLayer extends StatelessWidget {
  const _DevicesMarkersLayer();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrefsCubit, PrefsState>(
      buildWhen: (p, c) =>
          p.prefs.mapLayers.nearbyDevices != c.prefs.mapLayers.nearbyDevices,
      builder: (context, state) {
        final zoom = context.watch<double>();
        final enabled = state.prefs.mapLayers.nearbyDevices;

        if (!enabled) return const SizedBox();

        return BlocBuilder<NearbyCubit, NearbyState>(
          builder: (context, state) {
            if (state is NearbyConnected) {
              return RepaintBoundary(
                child: MarkerLayerWidget(
                  options: MarkerLayerOptions(
                    markers: state.trackingDevices
                        .map((d) => DeviceMarker(
                              device: d,
                              shrinkWhen: zoom < MapConfig.markerZoomThreshold,
                            ))
                        .toList(),
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }
}
