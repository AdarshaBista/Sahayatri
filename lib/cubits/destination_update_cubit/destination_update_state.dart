part of 'destination_update_cubit.dart';

abstract class DestinationUpdateState {
  const DestinationUpdateState();
}

class DestinationUpdateEmpty extends DestinationUpdateState {
  const DestinationUpdateEmpty();
}

class DestinationUpdateLoading extends DestinationUpdateState {
  const DestinationUpdateLoading();
}

class DestinationUpdateLoaded extends DestinationUpdateState {
  final List<DestinationUpdate> updates;

  const DestinationUpdateLoaded({
    required this.updates,
  });
}

class DestinationUpdateError extends DestinationUpdateState {
  final String message;

  const DestinationUpdateError({
    required this.message,
  });
}
