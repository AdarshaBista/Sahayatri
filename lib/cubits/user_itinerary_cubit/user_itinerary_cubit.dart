import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/app/database/itinerary_dao.dart';

part 'user_itinerary_state.dart';

class UserItineraryCubit extends Cubit<UserItineraryState> {
  final Destination destination;
  final ItineraryDao itineraryDao = locator();

  UserItineraryCubit({
    @required this.destination,
  })  : assert(destination != null),
        super(const UserItineraryEmpty());

  Itinerary get userItinerary => (state as UserItineraryLoaded).userItinerary;

  Future<void> getItinerary() async {
    emit(const UserItineraryLoading());
    final userItinerary = await itineraryDao.get(destination.id);

    if (userItinerary == null) {
      emit(const UserItineraryEmpty());
    } else {
      emit(UserItineraryLoaded(userItinerary: userItinerary));
    }
  }

  void createItinerary(Itinerary itinerary) {
    emit(UserItineraryLoaded(userItinerary: itinerary));
    itineraryDao.upsert(destination.id, itinerary);
  }

  void deleteItinerary() {
    emit(const UserItineraryEmpty());
    itineraryDao.delete(destination.id);
  }
}
