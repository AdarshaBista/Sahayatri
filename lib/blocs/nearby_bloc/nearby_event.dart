part of 'nearby_bloc.dart';

abstract class NearbyEvent extends Equatable {
  const NearbyEvent();

  @override
  List<Object> get props => [];
}

class NearbyStarted extends NearbyEvent {
  const NearbyStarted();
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

class DeviceChanged extends NearbyEvent {
  const DeviceChanged();
}
