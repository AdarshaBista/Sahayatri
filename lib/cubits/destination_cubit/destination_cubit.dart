import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/destination.dart';

class DestinationCubit extends Cubit<Destination> {
  final Destination destination;

  DestinationCubit({
    @required this.destination,
  })  : assert(destination != null),
        super(destination);

  void createItinerary(Itinerary itinerary) {
    destination.createdItinerary = itinerary;
    emit(destination);
  }
}
