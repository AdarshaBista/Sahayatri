import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/tracker_update.dart';
import 'package:sahayatri/core/extensions/coord_list_x.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/map_animator.dart';
import 'package:sahayatri/ui/shared/map/custom_map.dart';
import 'package:sahayatri/ui/shared/map/place_marker.dart';
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
    final trackerUpdate = context.watch<TrackerUpdate>();
    final center = trackerUpdate.currentLocation.coord;

    if (isTracking) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mapAnimator.move(center.toLatLng());
      });
    }

    return Stack(
      children: [
        _buildMap(center, trackerUpdate.userIndex),
        _buildTrackLocationButton(),
      ],
    );
  }

  Widget _buildMap(Coord center, int userIndex) {
    return Listener(
      onPointerUp: (_) => onPointerUp(),
      child: CustomMap(
        center: center,
        initialZoom: zoom,
        mapController: mapController,
        onPositionChanged: onPositionChanged,
        children: [
          _RouteLayer(zoom: zoom),
          const _DevicesAccuracyCircleLayer(),
          const _UserAccuracyCircleLayer(),
          const _UserMarkerLayer(),
          const _PlaceMarkersLayer(),
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

class _RouteLayer extends StatelessWidget {
  final double zoom;

  const _RouteLayer({
    @required this.zoom,
  }) : assert(zoom != null);

  @override
  Widget build(BuildContext context) {
    final trackerUpdate = context.watch<TrackerUpdate>();
    final userPath = trackerUpdate.userTrack.map((t) => t.coord).toList();

    return PolylineLayerWidget(
      options: PolylineLayerOptions(
        polylines: [
          Polyline(
            strokeWidth: 6.0,
            gradientColors: AppColors.accentColors.getRange(5, 8).toList(),
            points: [
              ...userPath.simplify(zoom).map((p) => p.toLatLng()).toList(),
              trackerUpdate.currentLocation.coord.toLatLng(),
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
    final destination = context.bloc<DestinationCubit>().destination;
    final places = destination.places;
    final checkpoints = destination.createdItinerary.checkpoints;
    final checkpointPlaces = checkpoints.map((c) => c.place).toList();
    final remainingPlaces = places.where((p) => !checkpointPlaces.contains(p)).toList();

    return MarkerLayerWidget(
      options: MarkerLayerOptions(
        markers: [
          for (final checkpoint in checkpoints) CheckpointMarker(checkpoint: checkpoint),
          for (int i = 0; i < remainingPlaces.length; ++i)
            PlaceMarker(
              place: remainingPlaces[i],
              color: AppColors.accentColors[i % AppColors.accentColors.length],
            ),
        ],
      ),
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

class _UserAccuracyCircleLayer extends StatelessWidget {
  const _UserAccuracyCircleLayer();

  @override
  Widget build(BuildContext context) {
    final trackerUpdate = context.watch<TrackerUpdate>();

    return CircleLayerWidget(
      options: CircleLayerOptions(
        circles: [
          AccuracyCircle(
            color: AppColors.primaryDark,
            point: trackerUpdate.currentLocation.coord,
            radius: trackerUpdate.currentLocation.accuracy,
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
    return BlocBuilder(
      cubit: context.bloc<NearbyCubit>(),
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
  }
}

class _DevicesAccuracyCircleLayer extends StatelessWidget {
  const _DevicesAccuracyCircleLayer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: context.bloc<NearbyCubit>(),
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
  }
}
