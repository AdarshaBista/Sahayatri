import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/app/database/itinerary_dao.dart';
import 'package:sahayatri/app/database/destination_dao.dart';

class DestinationCubit extends Cubit<Destination> {
  final Destination destination;
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

    destination.isDownloaded = false;
    destination.createdItinerary = createdItinerary;

    if (downloaded != null) {
      destination.isDownloaded = true;
      destination.createdItinerary = downloaded.createdItinerary;
      destination.places = downloaded.places;
      destination.reviews = downloaded.reviews;
      destination.suggestedItineraries = downloaded.suggestedItineraries;
      emit(destination);
    }
    return true;
  }

  Future<void> changeCreatedItinerary(Itinerary itinerary) async {
    destination.createdItinerary = itinerary;
    emit(destination);

    if (itinerary != null) {
      itineraryDao.upsert(destination.id, itinerary);
    } else {
      itineraryDao.delete(destination.id);
    }
  }
}
