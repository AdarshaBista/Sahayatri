import 'dart:async';

import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/user_location.dart';
import 'package:sahayatri/core/models/tracker_update.dart';

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
    if (event is TrackingPaused) yield* _mapTrackingPausedToState();
    if (event is TrackingResumed) yield* _mapTrackingResumedToState();
    if (event is TrackingStopped) yield* _mapTrackingStoppedToState();
    if (event is TrackingUpdated) yield TrackerUpdating(update: event.data);
    if (event is TrackingStarted) yield* _mapTrackingStartedToState(event.destination);
    if (event is TrackingAttempted) {
      yield* _mapTrackingAttemptedToState(event.destination);
    }
  }

  Stream<TrackerState> _mapTrackingPausedToState() async* {
    trackerService.pause();
    yield TrackerUpdating(
        update: (state as TrackerUpdating).update.copyWith(
              trackingState: TrackingState.paused,
            ));
  }

  Stream<TrackerState> _mapTrackingResumedToState() async* {
    trackerService.resume();
    yield TrackerUpdating(
      update: (state as TrackerUpdating)
          .update
          .copyWith(trackingState: TrackingState.updating),
    );
  }

  Stream<TrackerState> _mapTrackingStoppedToState() async* {
    smsService.stop();
    trackerService.stop();
    yield TrackerUpdating(
      update: (state as TrackerUpdating)
          .update
          .copyWith(trackingState: TrackingState.stopped),
    );
  }

  Stream<TrackerState> _mapTrackingAttemptedToState(Destination destination) async* {
    if (trackerService.isTracking) {
      add(TrackingStarted(destination: destination));
      return;
    }

    yield const TrackerLoading();
    try {
      final userLocation = await trackerService.getMockUserLocation(destination.route[0]);
      // final userLocation = await trackerService.getUserLocation();
      if (!trackerService.isNearTrail(userLocation.coord, destination.route)) {
        yield const TrackerLocationError();
        return;
      }

      yield const TrackerSettingUp();
    } on Failure catch (e) {
      print(e.error);
      yield TrackerError(message: e.message);
    }
  }

  Stream<TrackerState> _mapTrackingStartedToState(Destination destination) async* {
    yield const TrackerLoading();
    try {
      trackerService.start(destination);
      trackerService.onCompleted = () => add(const TrackingStopped());

      _trackerUpdateSub?.cancel();
      _trackerUpdateSub = trackerService.userLocationStream.listen((userLocation) {
        _updateTrackerData(userLocation, destination.route);
      });
    } on Failure catch (e) {
      print(e.error);
      yield TrackerError(message: e.message);
    }
  }

  void _updateTrackerData(UserLocation userLocation, List<Coord> route) {
    final nextCheckpoint = trackerService.nextCheckpoint(userLocation);
    final userIndex = trackerService.userIndex(userLocation.coord);

    offRouteAlertService.alert(userLocation.coord, route);
    smsService.send(userLocation.coord, nextCheckpoint?.checkpoint?.place);

    add(TrackingUpdated(
      data: TrackerUpdate(
        userIndex: userIndex,
        userLocation: userLocation,
        elapsed: trackerService.elapsedDuration(),
        nextCheckpoint: trackerService.nextCheckpoint(userLocation),
        distanceCovered: trackerService.distanceCovered(userIndex),
        distanceRemaining: trackerService.distanceRemaining(userIndex),
      ),
    ));
  }
}
