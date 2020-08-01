import 'package:meta/meta.dart';

class NearbyDevice {
  final String id;
  final String name;

  const NearbyDevice({
    @required this.id,
    @required this.name,
  })  : assert(id != null),
        assert(name != null);

  NearbyDevice copyWith({
    String id,
    String name,
  }) {
    return NearbyDevice(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'NearbyDevice(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NearbyDevice && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
