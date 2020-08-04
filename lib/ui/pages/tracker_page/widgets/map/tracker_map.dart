import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/core/utils/math_utls.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/tracker_update.dart';
import 'package:sahayatri/core/extensions/coord_list_x.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/map_animator.dart';
import 'package:sahayatri/ui/shared/widgets/map/custom_map.dart';
import 'package:sahayatri/ui/shared/widgets/map/place_marker.dart';
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

  void onPositionChanged(MapPosition pos, bool hasGesture) {
    if (MathUtils.shouldSimplify(zoom, pos.zoom) || (hasGesture && isTracking)) {
      print('SETSTATE');
      setState(() {
        zoom = pos.zoom;
        isTracking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final trackerUpdate = context.watch<TrackerUpdate>();
    final center = trackerUpdate.userLocation.coord;

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
    return CustomMap(
      center: center,
      initialZoom: zoom,
      mapController: mapController,
      onPositionChanged: onPositionChanged,
      children: [
        _RouteLayer(zoom: zoom),
        const _AccuracyCircleLayer(),
        const _DevicesMarkersLayer(),
        const _PlaceMarkersLayer(),
      ],
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
    final route = context.bloc<DestinationBloc>().destination.route;
    final userPath = route.take(trackerUpdate.userIndex).toList();

    return PolylineLayerWidget(
      options: PolylineLayerOptions(
        polylines: [
          Polyline(
            strokeWidth: 6.0,
            gradientColors: AppColors.accentColors.getRange(5, 8).toList(),
            points: [
              ...userPath.simplify(zoom).map((p) => p.toLatLng()).toList(),
              trackerUpdate.userLocation.coord.toLatLng(),
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
    final destination = context.bloc<DestinationBloc>().destination;
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

class _DevicesMarkersLayer extends StatelessWidget {
  const _DevicesMarkersLayer();

  @override
  Widget build(BuildContext context) {
    final userCoord = context.watch<TrackerUpdate>().userLocation.coord;
    final nearbyDevices = context.watch<TrackerUpdate>().nearbyDevices;
    final connected = nearbyDevices.where((d) => d.userLocation != null).toList();

    return RepaintBoundary(
      child: MarkerLayerWidget(
        options: MarkerLayerOptions(
          markers: [
            ...connected.map((d) => DeviceMarker(context, device: d)).toList(),
            UserMarker(point: userCoord),
          ],
        ),
      ),
    );
  }
}

class _AccuracyCircleLayer extends StatelessWidget {
  const _AccuracyCircleLayer();

  @override
  Widget build(BuildContext context) {
    final trackerUpdate = context.watch<TrackerUpdate>();
    final nearbyDevices = trackerUpdate.nearbyDevices;
    final connected = nearbyDevices.where((d) => d.userLocation != null).toList();

    return CircleLayerWidget(
      options: CircleLayerOptions(
        circles: [
          ...connected
              .map((d) => AccuracyCircle(
                    color: Colors.blue,
                    point: d.userLocation.coord,
                    radius: d.userLocation.accuracy,
                  ))
              .toList(),
          AccuracyCircle(
            color: AppColors.primaryDark,
            point: trackerUpdate.userLocation.coord,
            radius: trackerUpdate.userLocation.accuracy,
          ),
        ],
      ),
    );
  }
}
