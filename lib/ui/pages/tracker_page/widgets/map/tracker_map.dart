import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/map_animator.dart';
import 'package:sahayatri/ui/shared/widgets/map/custom_map.dart';
import 'package:sahayatri/ui/shared/widgets/map/place_marker.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/user_marker.dart';
import 'package:sahayatri/ui/pages/itinerary_page/widgets/checkpoint_marker.dart';
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
        CustomMap(
          center: center,
          initialZoom: 18.0,
          mapController: mapController,
          userIndex: trackerUpdate.userIndex,
          children: const [
            _AccuracyCircle(),
            _MarkerLayer(),
          ],
          onPositionChanged: (_, hasGesture) {
            if (hasGesture && isTracking) {
              setState(() {
                isTracking = false;
              });
            }
          },
        ),
        Positioned(
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
        ),
      ],
    );
  }
}

class _MarkerLayer extends StatelessWidget {
  const _MarkerLayer();

  @override
  Widget build(BuildContext context) {
    final destination = context.bloc<DestinationBloc>().destination;
    final places = destination.places;
    final checkpoints = destination.createdItinerary.checkpoints;
    final checkpointPlaces = checkpoints.map((c) => c.place).toList();
    final remainingPlaces = places.where((p) => !checkpointPlaces.contains(p)).toList();
    final center = context.watch<TrackerUpdate>().userLocation.coord;

    return MarkerLayerWidget(
      options: MarkerLayerOptions(
        markers: [
          for (int i = 0; i < remainingPlaces.length; ++i)
            PlaceMarker(
              place: remainingPlaces[i],
              color: AppColors.accentColors[i % AppColors.accentColors.length],
            ),
          for (int i = 0; i < checkpoints.length; ++i)
            CheckpointMarker(checkpoint: checkpoints[i]),
          UserMarker(point: center),
        ],
      ),
    );
  }
}

class _AccuracyCircle extends StatelessWidget {
  const _AccuracyCircle();

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
