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
          markerLayerOptions: _buildMarkers(context, center),
          circleLayerOptions: _buildAccuracyCircle(context, center),
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

  MarkerLayerOptions _buildMarkers(BuildContext context, Coord center) {
    final places = context.bloc<DestinationBloc>().destination.places;

    return MarkerLayerOptions(
      markers: [
        for (int i = 0; i < places.length; ++i)
          PlaceMarker(
            place: places[i],
            color: AppColors.accentColors[i % AppColors.accentColors.length],
          ),
        Marker(
          width: 24.0,
          height: 24.0,
          point: center.toLatLng(),
          builder: (context) => const UserMarker(),
        ),
      ],
    );
  }

  CircleLayerOptions _buildAccuracyCircle(BuildContext context, Coord center) {
    final trackerUpdate = context.watch<TrackerUpdate>();

    return CircleLayerOptions(
      circles: [
        CircleMarker(
          point: center.toLatLng(),
          borderStrokeWidth: 2.0,
          color: AppColors.primaryDark.withOpacity(0.2),
          borderColor: AppColors.primaryDark.withOpacity(0.5),
          useRadiusInMeter: true,
          radius: trackerUpdate.userLocation.accuracy,
        ),
      ],
    );
  }
}
