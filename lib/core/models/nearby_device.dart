import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/user_location.dart';

enum DeviceStatus { connected, connecting, disconnected }

class NearbyDevice {
  final String id;
  final String name;
  DeviceStatus status;
  UserLocation userLocation;

  NearbyDevice({
    @required this.id,
    @required this.name,
    @required this.status,
    this.userLocation,
  })  : assert(id != null),
        assert(name != null),
        assert(status != null);

  @override
  String toString() =>
      'NearbyDevice(id: $id, name: $name, status: $status, userLocation: $userLocation)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NearbyDevice && o.id == id && o.name == name;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ status.hashCode ^ userLocation.hashCode;
}
