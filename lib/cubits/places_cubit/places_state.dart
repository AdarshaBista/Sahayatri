part of 'places_cubit.dart';

abstract class PlacesState extends Equatable {
  const PlacesState();

  @override
  List<Object> get props => [];
}

class PlacesLoading extends PlacesState {
  const PlacesLoading();
}

class PlacesEmpty extends PlacesState {
  const PlacesEmpty();
}

class PlacesLoaded extends PlacesState {
  final List<Place> places;

  const PlacesLoaded({
    required this.places,
  });

  @override
  List<Object> get props => [places];
}

class PlacesError extends PlacesState {
  final String message;

  const PlacesError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
