part of 'destination_bloc.dart';

abstract class DestinationEvent extends Equatable {
  const DestinationEvent();

  @override
  List<Object> get props => [];
}

class ItineraryCreated extends DestinationEvent {
  final Itinerary itinerary;

  const ItineraryCreated({
    @required this.itinerary,
  });

  @override
  List<Object> get props => [itinerary];
}

class DestinationDownloaded extends DestinationEvent {}
