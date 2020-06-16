import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/core/services/tracker_service/tracker_service.dart';

part 'tracker_event.dart';
part 'tracker_state.dart';

class TrackerBloc extends Bloc<TrackerEvent, TrackerState> {
  final TrackerService trackerService;

  TrackerBloc({
    @required this.trackerService,
  }) : assert(trackerService != null);

  @override
  TrackerState get initialState => TrackerLoading();

  @override
  Stream<TrackerState> mapEventToState(
    TrackerEvent event,
  ) async* {
    if (event is TrackingStarted) {
      yield TrackerLoading();
      try {
        final UserLocation userLocation = await trackerService.getUserLocation();
        if (!trackerService.isNearTrail(userLocation.coord, event.route)) {
          yield TrackerLocationError();
          return;
        }

        yield TrackerSuccess(
          initialLocation: userLocation,
          userLocationStream: trackerService.getLocationStream(event.route),
        );
      } on Failure catch (e) {
        print(e.error);
        yield TrackerError(message: e.message);
      }
    }
  }
}
