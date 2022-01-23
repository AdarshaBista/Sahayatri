part of 'directions_cubit.dart';

abstract class DirectionsState extends Equatable {
  const DirectionsState();

  @override
  List<Object> get props => [];
}

class DirectionsInitial extends DirectionsState {
  const DirectionsInitial();
}

class DirectionsLoading extends DirectionsState {
  const DirectionsLoading();
}

class DirectionsError extends DirectionsState {
  final String message;

  const DirectionsError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
