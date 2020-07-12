part of 'itinerary_form_bloc.dart';

class ItineraryFormState {
  final String name;
  final String days;
  final String nights;
  final List<Checkpoint> checkpoints;

  Itinerary get itinerary => Itinerary(
        name: name.trim(),
        days: days.trim(),
        nights: nights.trim(),
        checkpoints: checkpoints,
      );

  const ItineraryFormState({
    @required this.name,
    @required this.days,
    @required this.nights,
    @required this.checkpoints,
  })  : assert(name != null),
        assert(days != null),
        assert(nights != null),
        assert(checkpoints != null);

  ItineraryFormState copyWith({
    String name,
    String days,
    String nights,
    List<Checkpoint> checkpoints,
  }) {
    return ItineraryFormState(
      name: name ?? this.name,
      days: days ?? this.days,
      nights: nights ?? this.nights,
      checkpoints: checkpoints ?? this.checkpoints,
    );
  }
}
