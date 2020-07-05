import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/tracker_data.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/core/services/sms_service.dart';
import 'package:sahayatri/core/services/offroute_alert_service.dart';
import 'package:sahayatri/core/services/tracker_service.dart';

part 'tracker_event.dart';
part 'tracker_state.dart';

class TrackerBloc extends Bloc<TrackerEvent, TrackerState> {
  final SmsService smsService;
  final TrackerService trackerService;
  final OffRouteAlertService offRouteAlertService;

  TrackerBloc({
    @required this.smsService,
    @required this.trackerService,
    @required this.offRouteAlertService,
  })  : assert(smsService != null),
        assert(trackerService != null),
        assert(offRouteAlertService != null),
        super(const TrackerLoading());

  @override
  Stream<TrackerState> mapEventToState(TrackerEvent event) async* {
    if (event is TrackingStarted) {
      yield* _mapTrackingStartedToState(event.destination);
    }
  }

  Stream<TrackerState> _mapTrackingStartedToState(Destination destination) async* {
    yield const TrackerLoading();
    try {
      final userLocation = await trackerService.getUserLocation(destination.route[0]);
      if (!trackerService.isNearTrail(userLocation.coord, destination.route)) {
        yield const TrackerLocationError();
        return;
      }

      trackerService.start(destination);
      await for (final userLocation in trackerService.locationStream) {
        yield* _getTrackerUpdates(userLocation, destination);
      }
      trackerService.stop();
      smsService.clear();
    } on Failure catch (e) {
      print(e.error);
      yield TrackerError(message: e.message);
    }
  }

  Stream<TrackerState> _getTrackerUpdates(
    UserLocation userLocation,
    Destination destination,
  ) async* {
    if (offRouteAlertService.shouldAlert(userLocation.coord, destination.route)) {
      offRouteAlertService.alert();
    }

    final elapsed = trackerService.getElapsedDuration();
    final nextStop = trackerService.getNextStop(userLocation);
    final userIndex = trackerService.getUserIndex(userLocation.coord);
    final distanceCovered = trackerService.getDistanceCovered(userIndex);
    final distanceRemaining = trackerService.getDistanceRemaining(userIndex);

    if (smsService.shouldSend(userLocation.coord, nextStop?.place)) {
      smsService.send(nextStop?.place);
    }

    yield TrackerSuccess(
      data: TrackerData(
        elapsed: elapsed,
        nextStop: nextStop,
        userIndex: userIndex,
        userLocation: userLocation,
        distanceCovered: distanceCovered,
        distanceRemaining: distanceRemaining,
      ),
    );
  }
}
