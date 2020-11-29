import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/api_service.dart';

part 'itinerary_state.dart';

class ItineraryCubit extends Cubit<ItineraryState> {
  final User user;
  final ApiService apiService;
  final Destination destination;

  ItineraryCubit({
    @required this.user,
    @required this.apiService,
    @required this.destination,
  })  : assert(user != null),
        assert(apiService != null),
        assert(destination != null),
        super(const ItineraryEmpty());

  Future<void> fetchItineraries() async {
    if (destination.suggestedItineraries != null) {
      emit(ItineraryLoaded(itineraries: destination.suggestedItineraries));
      return;
    }

    emit(const ItineraryLoading());
    try {
      final itineraries = await apiService.fetchItineraries(destination.id, user);
      if (itineraries.isNotEmpty) {
        destination.suggestedItineraries = itineraries;
        emit(ItineraryLoaded(itineraries: itineraries));
      } else {
        emit(const ItineraryEmpty());
      }
    } on AppError catch (e) {
      emit(ItineraryError(message: e.message));
    }
  }
}
