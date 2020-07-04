import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/destination.dart';

part 'destination_event.dart';
part 'destination_state.dart';

class DestinationBloc extends Bloc<DestinationEvent, DestinationState> {
  final Destination destination;

  DestinationBloc({
    @required this.destination,
  })  : assert(destination != null),
        super(DestinationState(destination: destination));

  @override
  Stream<DestinationState> mapEventToState(DestinationEvent event) async* {
    if (event is ItineraryCreated) {
      destination.createdItinerary = event.itinerary;
      yield DestinationState(destination: destination);
    }

    if (event is DestinationDownloaded) {
      destination.isDownloaded = true;
      yield DestinationState(destination: destination);
    }
  }
}
