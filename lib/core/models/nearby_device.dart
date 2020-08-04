import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/user_location.dart';

class NearbyDevice {
  final String id;
  final String name;
  bool isConnecting;
  UserLocation userLocation;

  NearbyDevice({
    @required this.id,
    @required this.name,
    this.userLocation,
    this.isConnecting = true,
  })  : assert(id != null),
        assert(name != null),
        assert(isConnecting != null);

  @override
  String toString() =>
      'NearbyDevice(id: $id, name: $name, isConnecting: $isConnecting, userLocation: $userLocation)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NearbyDevice && o.id == id && o.name == name;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ isConnecting.hashCode ^ userLocation.hashCode;
}
