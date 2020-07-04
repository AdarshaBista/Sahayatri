part of 'directions_bloc.dart';

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
    @required this.message,
  }) : assert(message != null);

  @override
  List<Object> get props => [message];
}
