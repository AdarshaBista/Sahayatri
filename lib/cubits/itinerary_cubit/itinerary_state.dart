part of 'itinerary_cubit.dart';

abstract class ItineraryState extends Equatable {
  const ItineraryState();

  @override
  List<Object> get props => [];
}

class ItineraryLoading extends ItineraryState {
  const ItineraryLoading();
}

class ItineraryEmpty extends ItineraryState {
  const ItineraryEmpty();
}

class ItineraryLoaded extends ItineraryState {
  final List<Itinerary> itineraries;

  const ItineraryLoaded({
    @required this.itineraries,
  }) : assert(itineraries != null);

  @override
  List<Object> get props => [itineraries];
}

class ItineraryError extends ItineraryState {
  final String message;

  const ItineraryError({
    @required this.message,
  }) : assert(message != null);

  @override
  List<Object> get props => [message];
}
