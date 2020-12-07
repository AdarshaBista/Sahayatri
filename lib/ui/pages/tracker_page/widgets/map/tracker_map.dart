import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/user_location.dart';
import 'package:sahayatri/core/models/tracker_update.dart';
import 'package:sahayatri/core/extensions/coord_list_x.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';
import 'package:sahayatri/cubits/user_itinerary_cubit/user_itinerary_cubit.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/map/custom_map.dart';
import 'package:sahayatri/ui/widgets/map/place_marker.dart';
import 'package:sahayatri/ui/widgets/animators/map_animator.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/user_marker.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/device_marker.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/accuracy_circle.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/checkpoint_marker.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/track_location_button.dart';

class TrackerMap extends StatefulWidget {
  const TrackerMap();

  @override
  _TrackerMapState createState() => _TrackerMapState();
}

class _TrackerMapState extends State<TrackerMap> with SingleTickerProviderStateMixin {
  double zoom;
  bool isTracking = true;
  bool shouldSimplifyRoute = false;
  MapAnimator mapAnimator;
  MapController mapController;

  @override
  void initState() {
    zoom = 18.0;
    mapController = MapController();
    mapAnimator = MapAnimator(mapController: mapController, tickerProvider: this);
    super.initState();
  }

  @override
  void dispose() {
    mapAnimator.dispose();
    super.dispose();
  }

  void onPointerUp() {
    if (shouldSimplifyRoute) {
      setState(() {
        shouldSimplifyRoute = false;
      });
    }
  }

  void onPositionChanged(MapPosition pos, bool hasGesture) {
    if (hasGesture && isTracking) {
      setState(() {
        isTracking = false;
      });
    }

    if (zoom != pos.zoom) {
      zoom = pos.zoom;
      shouldSimplifyRoute = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final center = context.select<TrackerUpdate, Coord>((u) => u.currentLocation.coord);

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
    return Listener(
      onPointerUp: (_) => onPointerUp(),
      child: CustomMap(
        center: center,
        initialZoom: zoom,
        mapController: mapController,
        onPositionChanged: onPositionChanged,
        children: [
          _UserTrackLayer(zoom: zoom),
          const _DevicesAccuracyCircleLayer(),
          const _UserAccuracyCircleLayer(),
          const _UserMarkerLayer(),
          const _PlaceMarkersLayer(),
          const _CheckpointMarkersLayer(),
          const _DevicesMarkersLayer(),
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
  final double zoom;

  const _UserTrackLayer({
    @required this.zoom,
  }) : assert(zoom != null);

  @override
  Widget build(BuildContext context) {
    final center = context.select<TrackerUpdate, Coord>((u) => u.currentLocation.coord);
    final userPath = context.select<TrackerUpdate, List<Coord>>(
        (u) => u.userTrack.map((t) => t.coord).toList());

    return PolylineLayerWidget(
      options: PolylineLayerOptions(
        polylines: [
          Polyline(
            strokeWidth: 6.0,
            gradientColors: AppColors.userTrackGradient,
            points: [
              ...userPath.simplify(zoom).map((p) => p.toLatLng()).toList(),
              center.toLatLng(),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlaceMarkersLayer extends StatelessWidget {
  const _PlaceMarkersLayer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrefsCubit, PrefsState>(
      buildWhen: (p, c) => p.prefs.mapLayers.places != c.prefs.mapLayers.places,
      builder: (context, state) {
        final enabled = state.prefs.mapLayers.places;
        if (!enabled) return const Offstage();

        final destination = context.watch<Destination>();
        final itinerary = BlocProvider.of<UserItineraryCubit>(context).userItinerary;
        final places = destination.places;
        final checkpoints = itinerary.checkpoints;
        final checkpointPlaces = checkpoints.map((c) => c.place).toList();
        final remainingPlaces =
            places.where((p) => !checkpointPlaces.contains(p)).toList();

        return MarkerLayerWidget(
          options: MarkerLayerOptions(
            markers: [
              for (int i = 0; i < remainingPlaces.length; ++i)
                PlaceMarker(
                  place: remainingPlaces[i],
                  color: AppColors.accents[i % AppColors.accents.length],
                ),
            ],
          ),
        );
      },
    );
  }
}

class _CheckpointMarkersLayer extends StatelessWidget {
  const _CheckpointMarkersLayer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrefsCubit, PrefsState>(
      buildWhen: (p, c) => p.prefs.mapLayers.checkpoints != c.prefs.mapLayers.checkpoints,
      builder: (context, state) {
        final enabled = state.prefs.mapLayers.checkpoints;
        if (!enabled) return const Offstage();

        final itinerary = BlocProvider.of<UserItineraryCubit>(context).userItinerary;
        final checkpoints = itinerary.checkpoints;

        return MarkerLayerWidget(
          options: MarkerLayerOptions(
            markers: [
              for (final checkpoint in checkpoints)
                CheckpointMarker(checkpoint: checkpoint),
            ],
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
    final userCoord =
        context.select<TrackerUpdate, Coord>((u) => u.currentLocation.coord);

    return RepaintBoundary(
      child: MarkerLayerWidget(
        options: MarkerLayerOptions(
          markers: [UserMarker(point: userCoord)],
        ),
      ),
    );
  }
}

class _UserAccuracyCircleLayer extends StatelessWidget {
  const _UserAccuracyCircleLayer();

  @override
  Widget build(BuildContext context) {
    final currentLocation =
        context.select<TrackerUpdate, UserLocation>((u) => u.currentLocation);

    return CircleLayerWidget(
      options: CircleLayerOptions(
        circles: [
          AccuracyCircle(
            color: AppColors.primaryDark,
            point: currentLocation.coord,
            radius: currentLocation.accuracy,
          ),
        ],
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
        final enabled = state.prefs.mapLayers.nearbyDevices;
        if (!enabled) return const Offstage();

        return BlocBuilder<NearbyCubit, NearbyState>(
          builder: (context, state) {
            if (state is NearbyConnected) {
              return RepaintBoundary(
                child: MarkerLayerWidget(
                  options: MarkerLayerOptions(
                    markers: state.trackingDevices
                        .map((d) => DeviceMarker(context, device: d))
                        .toList(),
                  ),
                ),
              );
            } else {
              return const Offstage();
            }
          },
        );
      },
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
        if (!enabled) return const Offstage();

        return BlocBuilder<NearbyCubit, NearbyState>(
          builder: (context, state) {
            if (state is NearbyConnected) {
              return RepaintBoundary(
                child: CircleLayerWidget(
                  options: CircleLayerOptions(
                    circles: state.trackingDevices
                        .map(
                          (d) => AccuracyCircle(
                            color: Colors.blue,
                            point: d.userLocation.coord,
                            radius: d.userLocation.accuracy,
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            } else {
              return const Offstage();
            }
          },
        );
      },
    );
  }
}
