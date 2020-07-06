import 'dart:async';

import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/tracker_data.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/core/services/sms_service.dart';
import 'package:sahayatri/core/services/tracker_service.dart';
import 'package:sahayatri/core/services/offroute_alert_service.dart';

part 'tracker_event.dart';
part 'tracker_state.dart';

class TrackerBloc extends Bloc<TrackerEvent, TrackerState> {
  final SmsService smsService;
  final TrackerService trackerService;
  final OffRouteAlertService offRouteAlertService;

  StreamSubscription _trackerUpdateSub;

  TrackerBloc({
    @required this.smsService,
    @required this.trackerService,
    @required this.offRouteAlertService,
  })  : assert(smsService != null),
        assert(trackerService != null),
        assert(offRouteAlertService != null),
        super(const TrackerLoading());

  @override
  Future<void> close() {
    _trackerUpdateSub?.cancel();
    return super.close();
  }

  @override
  Stream<TrackerState> mapEventToState(TrackerEvent event) async* {
    if (event is TrackingStarted) {
      yield* _mapTrackingStartedToState(event.destination);
    }
    if (event is TrackingUpdated) {
      yield TrackerUpdating(data: event.data);
    }
    if (event is TrackingStopped) {
      smsService.clear();
      trackerService.stop();
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
      trackerService.onCompleted = () => add(const TrackingStopped());
      _trackerUpdateSub?.cancel();
      _trackerUpdateSub = trackerService.userLocationStream.listen((userLocation) {
        _updateTrackerData(userLocation, destination);
      });
    } on Failure catch (e) {
      print(e.error);
      yield TrackerError(message: e.message);
    }
  }

  void _updateTrackerData(UserLocation userLocation, Destination destination) {
    final elapsed = trackerService.getElapsedDuration();
    final nextStop = trackerService.getNextStop(userLocation);
    final userIndex = trackerService.getUserIndex(userLocation.coord);
    final distanceCovered = trackerService.getDistanceCovered(userIndex);
    final distanceRemaining = trackerService.getDistanceRemaining(userIndex);

    smsService.send(userLocation.coord, nextStop?.place);
    offRouteAlertService.alert(userLocation.coord, destination.route);

    add(TrackingUpdated(
      data: TrackerData(
        elapsed: elapsed,
        nextStop: nextStop,
        userIndex: userIndex,
        userLocation: userLocation,
        distanceCovered: distanceCovered,
        distanceRemaining: distanceRemaining,
      ),
    ));
  }
}
