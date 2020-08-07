import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/core/services/directions_service.dart';

part 'directions_state.dart';

class DirectionsCubit extends Cubit<DirectionsState> {
  final DirectionsService directionsService;

  DirectionsCubit({
    @required this.directionsService,
  })  : assert(directionsService != null),
        super(const DirectionsInitial());

  Future<void> startNavigation(
    Place trailHead,
    // NavigationMode mode,
  ) async {
    emit(const DirectionsLoading());
    try {
      final UserLocation userLocation = await directionsService.getUserLocation();
      await directionsService.startNavigation(
        trailHead,
        userLocation,
        // mode,
      );
      emit(const DirectionsInitial());
    } on Failure catch (e) {
      print(e.error);
      emit(DirectionsError(message: e.message));
    }
  }
}
