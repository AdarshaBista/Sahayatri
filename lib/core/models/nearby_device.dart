import 'package:sahayatri/core/models/user_location.dart';

enum DeviceStatus { connected, connecting, disconnected }

class NearbyDevice {
  final String id;
  final String name;
  DeviceStatus status;
  UserLocation? userLocation;

  NearbyDevice({
    required this.id,
    required this.name,
    required this.status,
    this.userLocation,
  });

  @override
  String toString() =>
      'NearbyDevice(id: $id, name: $name, status: $status, userLocation: $userLocation)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NearbyDevice && other.id == id && other.name == name;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ status.hashCode ^ userLocation.hashCode;
}
