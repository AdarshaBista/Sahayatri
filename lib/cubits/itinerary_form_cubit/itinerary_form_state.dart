part of 'itinerary_form_cubit.dart';

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
    required this.name,
    required this.days,
    required this.nights,
    required this.checkpoints,
  });

  ItineraryFormState copyWith({
    String? name,
    String? days,
    String? nights,
    List<Checkpoint>? checkpoints,
  }) {
    return ItineraryFormState(
      name: name ?? this.name,
      days: days ?? this.days,
      nights: nights ?? this.nights,
      checkpoints: checkpoints ?? this.checkpoints,
    );
  }

  bool isDirty(Itinerary? initial) {
    if (initial == null) {
      return name.isNotEmpty ||
          days.isNotEmpty ||
          nights.isNotEmpty ||
          checkpoints.isNotEmpty;
    }

    return initial.name != name ||
        initial.days != days ||
        initial.nights != nights ||
        !listEquals(initial.checkpoints, checkpoints);
  }
}
