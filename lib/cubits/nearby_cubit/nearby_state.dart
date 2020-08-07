part of 'nearby_cubit.dart';

abstract class NearbyState {
  const NearbyState();
}

class NearbyInitial extends NearbyState {
  const NearbyInitial();
}

class NearbyConnected extends NearbyState {
  final bool isScanning;
  final List<NearbyDevice> nearbyDevices;

  const NearbyConnected({
    this.isScanning = true,
    @required this.nearbyDevices,
  })  : assert(isScanning != null),
        assert(nearbyDevices != null);
}

class NearbyError extends NearbyState {
  final String message;

  const NearbyError({
    @required this.message,
  }) : assert(message != null);
}
