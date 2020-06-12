import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/core/services/directions_service.dart';

part 'directions_event.dart';
part 'directions_state.dart';

class DirectionsBloc extends Bloc<DirectionsEvent, DirectionsState> {
  final DirectionsService directionsService;

  DirectionsBloc({
    @required this.directionsService,
  }) : assert(directionsService != null);

  @override
  DirectionsState get initialState => DirectionsInitial();

  @override
  Stream<DirectionsState> mapEventToState(DirectionsEvent event) async* {
    if (event is DirectionsStarted) {
      yield DirectionsLoading();
      try {
        final UserLocation userLocation = await directionsService.getUserLocation();
        await directionsService.startNavigation(
          event.trailHead,
          userLocation,
          // event.mode,
        );
        yield DirectionsInitial();
      } on Failure catch (e) {
        print(e.error);
        yield DirectionsError(message: e.message);
      }
    }
  }
}
