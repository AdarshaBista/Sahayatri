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
    final isDownloaded = await destinationDao.contains(destination.id);
    final createdItinerary = await itineraryDao.get(destination.id);
    destination.isDownloaded = isDownloaded;
    destination.createdItinerary = createdItinerary;
    emit(destination);
    return true;
  }

  void createItinerary(Itinerary itinerary) {
    destination.createdItinerary = itinerary;
    emit(destination);
    itineraryDao.upsert(destination.id, itinerary);
  }

  void deleteItinerary() {
    destination.createdItinerary = null;
    emit(destination);
    itineraryDao.delete(destination.id);
  }
}
