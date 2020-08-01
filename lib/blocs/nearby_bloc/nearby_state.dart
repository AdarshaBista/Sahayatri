part of 'nearby_bloc.dart';

abstract class NearbyState extends Equatable {
  const NearbyState();

  @override
  List<Object> get props => [];
}

class NearbyInitial extends NearbyState {
  const NearbyInitial();
}

class NearbyInProgress extends NearbyState {
  final bool isScanning;
  final List<NearbyDevice> connected;

  const NearbyInProgress({
    this.isScanning = true,
    @required this.connected,
  })  : assert(connected != null),
        assert(isScanning != null);

  @override
  List<Object> get props => [isScanning, connected];
}

class NearbyError extends NearbyState {
  final String message;

  const NearbyError({
    @required this.message,
  }) : assert(message != null);

  @override
  List<Object> get props => [message];
}
