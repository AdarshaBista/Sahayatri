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
import 'package:sahayatri/core/services/nearby_service.dart';
import 'package:sahayatri/core/services/tracker_service.dart';
import 'package:sahayatri/core/services/offroute_alert_service.dart';

part 'tracker_state.dart';

class TrackerCubit extends Cubit<TrackerState> {
  final SmsService smsService;
  final NearbyService nearbyService;
  final TrackerService trackerService;
  final OffRouteAlertService offRouteAlertService;
  StreamSubscription _trackerUpdateSub;

  TrackerCubit({
    @required this.smsService,
    @required this.nearbyService,
    @required this.trackerService,
    @required this.offRouteAlertService,
  })  : assert(smsService != null),
        assert(nearbyService != null),
        assert(trackerService != null),
        assert(offRouteAlertService != null),
        super(const TrackerLoading());

  @override
  Future<void> close() async {
    _trackerUpdateSub?.cancel();
    await super.close();
  }

  bool get isTracking => trackerService.isTracking;

  Duration get elapsed => trackerService.elapsedDuration();

  Future<void> pauseTracking() async {
    trackerService.pause();
    emit(
      TrackerUpdating(
        update: (state as TrackerUpdating)
            .update
            .copyWith(trackingState: TrackingState.paused),
      ),
    );
  }

  Future<void> resumeTracking() async {
    trackerService.resume();
    emit(TrackerUpdating(
      update: (state as TrackerUpdating)
          .update
          .copyWith(trackingState: TrackingState.updating),
    ));
  }

  Future<void> stopTracking() async {
    smsService.stop();
    trackerService.stop();

    emit(TrackerUpdating(
      update: (state as TrackerUpdating)
          .update
          .copyWith(trackingState: TrackingState.stopped),
    ));
  }

  Future<void> attemptTracking(Destination destination) async {
    if (trackerService.isTracking) {
      startTracking(destination);
      return;
    }

    emit(const TrackerLoading());
    try {
      final userLocation = await trackerService.getMockUserLocation(destination.route[0]);
      // final userLocation = await trackerService.getUserLocation();
      if (!trackerService.isNearTrail(userLocation.coord, destination.route)) {
        emit(const TrackerLocationError());
        return;
      }

      emit(const TrackerSettingUp());
    } on Failure catch (e) {
      print(e.error);
      emit(TrackerError(message: e.message));
    }
  }

  Future<void> startTracking(Destination destination) async {
    emit(const TrackerLoading());
    try {
      trackerService.start(destination);
      trackerService.onCompleted = stopTracking;

      _trackerUpdateSub?.cancel();
      _trackerUpdateSub = trackerService.userLocationStream.listen((userLocation) {
        _updateTrackerData(userLocation, destination.route);
      });
    } on Failure catch (e) {
      print(e.error);
      emit(TrackerError(message: e.message));
    }
  }

  void _updateTrackerData(UserLocation userLocation, List<Coord> route) {
    final nextCheckpoint = trackerService.nextCheckpoint(userLocation);
    final userIndex = trackerService.userIndex(userLocation.coord);

    nearbyService.broadcastLocation(userLocation);
    offRouteAlertService.alert(userLocation.coord, route);
    smsService.send(userLocation.coord, nextCheckpoint?.checkpoint?.place);

    emit(TrackerUpdating(
      update: TrackerUpdate(
        userIndex: userIndex,
        userTrack: trackerService.userTrack,
        elapsed: trackerService.elapsedDuration(),
        nextCheckpoint: trackerService.nextCheckpoint(userLocation),
        distanceCovered: trackerService.distanceCovered(userIndex),
        distanceRemaining: trackerService.distanceRemaining(userIndex),
      ),
    ));
  }
}
