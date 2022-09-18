import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/services/api_service.dart';

import 'package:sahayatri/locator.dart';

part 'itinerary_state.dart';

class ItineraryCubit extends Cubit<ItineraryState> {
  final User? user;
  final Destination destination;
  final ApiService apiService = locator();

  ItineraryCubit({
    required this.user,
    required this.destination,
  }) : super(const ItineraryEmpty());

  Future<void> fetchItineraries() async {
    if (user == null) return;

    if (destination.suggestedItineraries != null) {
      emit(ItineraryLoaded(
        itineraries: destination.suggestedItineraries ?? [],
      ));
      return;
    }

    emit(const ItineraryLoading());
    try {
      final itineraries =
          await apiService.fetchItineraries(destination.id, user!);
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
