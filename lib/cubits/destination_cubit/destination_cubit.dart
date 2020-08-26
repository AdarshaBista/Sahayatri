import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/app/database/destination_dao.dart';

class DestinationCubit extends Cubit<Destination> {
  Destination destination;
  final DestinationDao destinationDao;

  DestinationCubit({
    @required this.destination,
    @required this.destinationDao,
  })  : assert(destination != null),
        assert(destinationDao != null),
        super(destination);

  Future<bool> checkDownload() async {
    final downloaded = await destinationDao.get(destination.id);
    destination.isDownloaded = false;

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

  void createItinerary(Itinerary itinerary) {
    destination.createdItinerary = itinerary;
    emit(destination);
  }
}
