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

  List<NearbyDevice> get connectedDevices => nearbyDevices
      .where((d) => d.status != DeviceStatus.disconnected)
      .toList();
  List<NearbyDevice> get trackingDevices =>
      nearbyDevices.where((d) => d.userLocation != null).toList();

  const NearbyConnected({
    this.isScanning = true,
    required this.nearbyDevices,
  });
}

class NearbyError extends NearbyState {
  final String message;

  const NearbyError({
    required this.message,
  });
}
