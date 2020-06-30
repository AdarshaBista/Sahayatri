import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/tracker_data.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/core/services/user_alert_service.dart';
import 'package:sahayatri/core/services/tracker_service/tracker_service.dart';

part 'tracker_event.dart';
part 'tracker_state.dart';

class TrackerBloc extends Bloc<TrackerEvent, TrackerState> {
  final TrackerService trackerService;
  final UserAlertService userAlertService;

  TrackerBloc({
    @required this.trackerService,
    @required this.userAlertService,
  })  : assert(trackerService != null),
        assert(userAlertService != null);

  @override
  TrackerState get initialState => TrackerLoading();

  @override
  Stream<TrackerState> mapEventToState(TrackerEvent event) async* {
    if (event is TrackingStarted) {
      yield* _mapTrackingStartedToState(event.destination);
    }
  }

  Stream<TrackerState> _mapTrackingStartedToState(Destination destination) async* {
    yield TrackerLoading();
    try {
      final route = destination.routePoints;
      final UserLocation userLocation = await trackerService.getUserLocation();

      if (!trackerService.isNearTrail(userLocation.coord, route)) {
        yield TrackerLocationError();
        return;
      }

      await for (final userLocation in trackerService.getLocationStream(route)) {
        yield* _getTrackerUpdates(userLocation, destination);
      }
    } on Failure catch (e) {
      print(e.error);
      yield TrackerError(message: e.message);
    }
  }

  Stream<TrackerState> _getTrackerUpdates(
    UserLocation userLocation,
    Destination destination,
  ) async* {
    final route = destination.routePoints;
    final places = destination.places;
    if (trackerService.shouldAlertUser(userLocation.coord, route)) {
      userAlertService.alert();
    }

    final nextStop = trackerService.getNextStop(userLocation.coord, places, route);
    final eta = trackerService.getEta(userLocation, nextStop, route);
    final userIndex = trackerService.getUserIndex(userLocation.coord, route);
    final distanceWalked = trackerService.getDistanceWalked(userIndex, route);
    final distanceRemaining = trackerService.getDistanceRemaining(userIndex, route);

    yield TrackerSuccess(
      data: TrackerData(
        eta: eta,
        nextStop: nextStop,
        userIndex: userIndex,
        userLocation: userLocation,
        distanceWalked: distanceWalked,
        distanceRemaining: distanceRemaining,
      ),
    );
  }
}
