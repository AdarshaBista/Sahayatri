import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/map_animator.dart';
import 'package:sahayatri/ui/shared/widgets/map/custom_map.dart';
import 'package:sahayatri/ui/shared/widgets/map/place_marker.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/user_marker.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/checkpoint_marker.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/track_location_button.dart';

class TrackerMap extends StatefulWidget {
  const TrackerMap();

  @override
  _TrackerMapState createState() => _TrackerMapState();
}

class _TrackerMapState extends State<TrackerMap> with SingleTickerProviderStateMixin {
  bool isTracking = true;
  MapAnimator mapAnimator;
  MapController mapController;

  @override
  void initState() {
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
    if (hasGesture && isTracking) {
      setState(() {
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
      showRoute: false,
      initialZoom: 18.0,
      mapController: mapController,
      onPositionChanged: onPositionChanged,
      children: [
        _RouteLayer(userIndex: userIndex, userCoord: center),
        const _AccuracyCircleLayer(),
        const _MarkersLayer(),
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

class _MarkersLayer extends StatelessWidget {
  const _MarkersLayer();

  @override
  Widget build(BuildContext context) {
    final destination = context.bloc<DestinationBloc>().destination;
    final places = destination.places;
    final checkpoints = destination.createdItinerary.checkpoints;
    final checkpointPlaces = checkpoints.map((c) => c.place).toList();
    final remainingPlaces = places.where((p) => !checkpointPlaces.contains(p)).toList();
    final userCoord = context.watch<TrackerUpdate>().userLocation.coord;

    return MarkerLayerWidget(
      options: MarkerLayerOptions(
        markers: [
          UserMarker(point: userCoord),
          for (int i = 0; i < checkpointPlaces.length; ++i)
            CheckpointMarker(place: checkpointPlaces[i]),
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

class _AccuracyCircleLayer extends StatelessWidget {
  const _AccuracyCircleLayer();

  @override
  Widget build(BuildContext context) {
    final trackerUpdate = context.watch<TrackerUpdate>();

    return CircleLayerWidget(
      options: CircleLayerOptions(
        circles: [
          CircleMarker(
            useRadiusInMeter: true,
            borderStrokeWidth: 2.0,
            radius: trackerUpdate.userLocation.accuracy,
            point: trackerUpdate.userLocation.coord.toLatLng(),
            color: AppColors.primaryDark.withOpacity(0.2),
            borderColor: AppColors.primaryDark.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}

class _RouteLayer extends StatelessWidget {
  final int userIndex;
  final Coord userCoord;

  const _RouteLayer({
    @required this.userIndex,
    @required this.userCoord,
  })  : assert(userIndex != null),
        assert(userCoord != null);

  @override
  Widget build(BuildContext context) {
    final route = context.bloc<DestinationBloc>().destination.route;
    final userPath = route.take(userIndex).toList();
    final remainingStartIndex = userIndex > 0 ? userIndex - 1 : 0;
    final remainingPath = route.getRange(remainingStartIndex, route.length).toList();

    return PolylineLayerWidget(
      options: PolylineLayerOptions(
        polylines: [
          Polyline(
            strokeWidth: 6.0,
            gradientColors: AppColors.accentColors.take(4).toList(),
            points: remainingPath.map((p) => p.toLatLng()).toList(),
          ),
          Polyline(
            strokeWidth: 6.0,
            gradientColors: AppColors.accentColors.getRange(5, 8).toList(),
            points: [
              ...userPath.map((p) => p.toLatLng()).toList(),
              userCoord.toLatLng(),
            ],
          ),
        ],
      ),
    );
  }
}
