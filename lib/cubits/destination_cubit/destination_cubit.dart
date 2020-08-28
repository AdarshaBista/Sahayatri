import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/app/database/itinerary_dao.dart';
import 'package:sahayatri/app/database/destination_dao.dart';

class DestinationCubit extends Cubit<Destination> {
  Destination destination;
  final ItineraryDao itineraryDao;
  final DestinationDao destinationDao;

  DestinationCubit({
    @required this.destination,
    @required this.itineraryDao,
    @required this.destinationDao,
  })  : assert(destination != null),
        assert(itineraryDao != null),
        assert(destinationDao != null),
        super(destination);

  Future<bool> open() async {
    final downloaded = await destinationDao.get(destination.id);
    final createdItinerary = await itineraryDao.get(destination.id);

    destination = destination.copyWith(
      isDownloaded: false,
      createdItinerary: createdItinerary,
    );

    if (downloaded != null) {
      destination = destination.copyWith(
        isDownloaded: true,
        createdItinerary: downloaded.createdItinerary,
        places: downloaded.places,
        reviews: downloaded.reviews,
        suggestedItineraries: downloaded.suggestedItineraries,
      );
      emit(destination);
    }
    return true;
  }

  void createItinerary(Itinerary itinerary) {
    destination = destination.copyWith(createdItinerary: itinerary);
    emit(destination);
    itineraryDao.upsert(destination.id, itinerary);
  }

  void deleteItinerary() {
    destination = destination.copyWith()..createdItinerary = null;
    emit(destination);
    itineraryDao.delete(destination.id);
  }
}
