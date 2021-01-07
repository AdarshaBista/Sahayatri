import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';
import 'package:sahayatri/cubits/user_itinerary_cubit/user_itinerary_cubit.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/map_animator.dart';
import 'package:sahayatri/ui/widgets/map/custom_map.dart';
import 'package:sahayatri/ui/widgets/map/markers/place_marker.dart';
import 'package:sahayatri/ui/widgets/map/markers/checkpoint_detail_marker.dart';
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
          _CheckpointsPlacesMarkersLayer(zoom: zoom),
          _DevicesMarkersLayer(zoom: zoom),
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
    final trackerUpdate = context.watch<TrackerUpdate>();
    final center = trackerUpdate.currentLocation.coord;
    final userPath = trackerUpdate.userTrack.map((t) => t.coord).toList();

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

class _UserAccuracyCircleLayer extends StatelessWidget {
  const _UserAccuracyCircleLayer();

  @override
  Widget build(BuildContext context) {
    final currentLocation = context.watch<TrackerUpdate>().currentLocation;

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
              return CircleLayerWidget(
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

class _CheckpointsPlacesMarkersLayer extends StatelessWidget {
  final double zoom;

  const _CheckpointsPlacesMarkersLayer({
    @required this.zoom,
  }) : assert(zoom != null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrefsCubit, PrefsState>(
      buildWhen: (p, c) =>
          p.prefs.mapLayers.places != c.prefs.mapLayers.places ||
          p.prefs.mapLayers.checkpoints != c.prefs.mapLayers.checkpoints,
      builder: (context, state) {
        final placesEnabled = state.prefs.mapLayers.places;
        final checkpointsEnabled = state.prefs.mapLayers.checkpoints;
        if (!placesEnabled && !checkpointsEnabled) return const Offstage();

        final List<Place> places = [];
        final List<Marker> markers = [];

        if (placesEnabled) {
          final destination = context.watch<Destination>();
          places.addAll(destination.places);
        }

        if (checkpointsEnabled) {
          final itinerary = BlocProvider.of<UserItineraryCubit>(context).userItinerary;
          markers.addAll(itinerary.checkpoints.map(
            (c) {
              if (zoom < MapConfig.markerZoomThreshold) {
                return CheckpointMarker(checkpoint: c);
              }
              return CheckpointDetailMarker(checkpoint: c);
            },
          ));

          if (placesEnabled) {
            final checkpointPlaces = itinerary.checkpoints.map((c) => c.place).toList();
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
    final userCoord = context.watch<TrackerUpdate>().currentLocation.coord;

    return RepaintBoundary(
      child: MarkerLayerWidget(
        options: MarkerLayerOptions(
          markers: [UserMarker(point: userCoord)],
        ),
      ),
    );
  }
}

class _DevicesMarkersLayer extends StatelessWidget {
  final double zoom;

  const _DevicesMarkersLayer({
    @required this.zoom,
  }) : assert(zoom != null);

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
                        .map((d) => DeviceMarker(
                              device: d,
                              shrinkWhen: zoom < MapConfig.markerZoomThreshold,
                            ))
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
