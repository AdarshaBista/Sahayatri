import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:sahayatri/core/services/nearby/nearby_service.dart';
import 'package:sahayatri/core/services/offroute_alert_service.dart';
import 'package:sahayatri/core/services/tracker/tracker_service.dart';

part 'tracker_state.dart';

class TrackerCubit extends Cubit<TrackerState> {
  final NearbyService nearbyService = locator();
  final TrackerService trackerService = locator();
  final OffRouteAlertService offRouteAlertService = locator();
  StreamSubscription? _trackerUpdateSub;

  TrackerCubit() : super(const TrackerLoading()) {
    trackerService.onCompleted = stopTracking;
  }

  @override
  Future<void> close() async {
    _trackerUpdateSub?.cancel();
    await super.close();
  }

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
    await trackerService.stop();

    emit(TrackerUpdating(
      update: (state as TrackerUpdating)
          .update
          .copyWith(trackingState: TrackingState.stopped),
    ));
  }

  Future<void> attemptTracking(
    Destination destination,
    Itinerary itinerary,
  ) async {
    if (trackerService.isTracking) {
      startTracking(destination, itinerary);
      return;
    }

    emit(const TrackerLoading());
    try {
      if (!await trackerService.isNearTrail(destination.route)) {
        emit(const TrackerLocationError());
        return;
      }

      emit(const TrackerSettingUp());
    } on AppError catch (e) {
      emit(TrackerError(message: e.message));
    }
  }

  Future<void> startTracking(
      Destination destination, Itinerary itinerary) async {
    emit(const TrackerLoading());
    try {
      await trackerService.start(destination, itinerary);

      _trackerUpdateSub?.cancel();
      _trackerUpdateSub =
          trackerService.trackerUpdateStream.listen((trackerUpdate) {
        _updateTrackerData(trackerUpdate, destination.route);
      });
    } on AppError catch (e) {
      emit(TrackerError(message: e.message));
    }
  }

  void _updateTrackerData(TrackerUpdate trackerUpdate, List<Coord> route) {
    final userLocation = trackerUpdate.currentLocation;
    offRouteAlertService.alert(!trackerUpdate.isOffRoute);
    nearbyService.messagesService.broadcastLocation(userLocation);

    emit(TrackerUpdating(update: trackerUpdate));
  }

  void changeItinerary(Itinerary itinerary) {
    if (!trackerService.isTracking) return;
    trackerService.itinerary = itinerary;
  }
}
