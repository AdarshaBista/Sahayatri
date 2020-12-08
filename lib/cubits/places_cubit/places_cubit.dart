import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/api_service.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  final User user;
  final Destination destination;
  final ApiService apiService = locator();

  PlacesCubit({
    @required this.user,
    @required this.destination,
  })  : assert(user != null),
        assert(destination != null),
        super(const PlacesEmpty());

  Future<void> fetchPlaces() async {
    if (user == null) return;

    if (destination.places != null) {
      emit(PlacesLoaded(places: destination.places));
      return;
    }

    emit(const PlacesLoading());
    try {
      final places = await apiService.fetchPlaces(destination.id, user);
      if (places.isNotEmpty) {
        destination.places = places;
        emit(PlacesLoaded(places: places));
      } else {
        emit(const PlacesEmpty());
      }
    } on AppError catch (e) {
      emit(PlacesError(message: e.message));
    }
  }
}
