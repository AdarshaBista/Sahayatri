part of 'nearby_bloc.dart';

abstract class NearbyEvent extends Equatable {
  const NearbyEvent();

  @override
  List<Object> get props => [];
}

class NearbyStarted extends NearbyEvent {
  final String name;

  const NearbyStarted({
    @required this.name,
  }) : assert(name != null);

  @override
  List<Object> get props => [name];
}

class NearbyStopped extends NearbyEvent {
  const NearbyStopped();
}

class ScanningStarted extends NearbyEvent {
  const ScanningStarted();
}

class ScanningStopped extends NearbyEvent {
  const ScanningStopped();
}

class DeviceListChanged extends NearbyEvent {
  const DeviceListChanged();
}
