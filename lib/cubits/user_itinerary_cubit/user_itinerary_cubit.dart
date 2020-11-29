import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/app/database/itinerary_dao.dart';

part 'user_itinerary_state.dart';

class UserItineraryCubit extends Cubit<UserItineraryState> {
  final Destination destination;
  final ItineraryDao itineraryDao;

  UserItineraryCubit({
    @required this.destination,
    @required this.itineraryDao,
  })  : assert(destination != null),
        assert(itineraryDao != null),
        super(const UserItineraryEmpty());

  Future<void> getItinerary() async {
    if (destination.createdItinerary != null) {
      emit(UserItineraryLoaded(createdItinerary: destination.createdItinerary));
      return;
    }

    emit(const UserItineraryLoading());
    final createdItinerary = await itineraryDao.get(destination.id);

    if (createdItinerary == null) {
      emit(const UserItineraryEmpty());
    } else {
      destination.createdItinerary = createdItinerary;
      emit(UserItineraryLoaded(createdItinerary: createdItinerary));
    }
  }

  void createItinerary(Itinerary itinerary) {
    destination.createdItinerary = itinerary;
    emit(UserItineraryLoaded(createdItinerary: itinerary));
    itineraryDao.upsert(destination.id, itinerary);
  }

  void deleteItinerary() {
    destination.createdItinerary = null;
    emit(const UserItineraryEmpty());
    itineraryDao.delete(destination.id);
  }
}
