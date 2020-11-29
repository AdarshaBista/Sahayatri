part of 'user_itinerary_cubit.dart';

abstract class UserItineraryState extends Equatable {
  const UserItineraryState();

  @override
  List<Object> get props => [];
}

class UserItineraryLoading extends UserItineraryState {
  const UserItineraryLoading();
}

class UserItineraryEmpty extends UserItineraryState {
  const UserItineraryEmpty();
}

class UserItineraryLoaded extends UserItineraryState {
  final Itinerary createdItinerary;

  const UserItineraryLoaded({
    @required this.createdItinerary,
  }) : assert(createdItinerary != null);

  @override
  List<Object> get props => [createdItinerary];
}
