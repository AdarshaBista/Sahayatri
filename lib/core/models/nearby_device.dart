import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/user_location.dart';

class NearbyDevice {
  final String id;
  final String name;
  UserLocation userLocation;

  NearbyDevice({
    @required this.id,
    @required this.name,
    this.userLocation,
  })  : assert(id != null),
        assert(name != null);

  NearbyDevice copyWith({
    String id,
    String name,
    UserLocation userLocation,
  }) {
    return NearbyDevice(
      id: id ?? this.id,
      name: name ?? this.name,
      userLocation: userLocation ?? this.userLocation,
    );
  }

  @override
  String toString() => 'NearbyDevice(id: $id, name: $name, userLocation: $userLocation)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NearbyDevice && o.id == id;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ userLocation.hashCode;
}
