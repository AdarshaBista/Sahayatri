part of 'tracker_cubit.dart';

abstract class TrackerState extends Equatable {
  const TrackerState();

  @override
  List<Object> get props => [];
}

class TrackerLoading extends TrackerState {
  const TrackerLoading();
}

class TrackerLocationError extends TrackerState {
  const TrackerLocationError();
}

class TrackerSettingUp extends TrackerState {
  const TrackerSettingUp();
}

class TrackerUpdating extends TrackerState {
  final TrackerUpdate update;

  const TrackerUpdating({
    required this.update,
  });

  @override
  List<Object> get props => [update];
}

class TrackerError extends TrackerState {
  final String message;

  const TrackerError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
