import 'package:meta/meta.dart';

class NearbyMessage {
  final String type;
  final String body;

  const NearbyMessage({
    @required this.type,
    @required this.body,
  })  : assert(type != null),
        assert(body != null);

  @override
  String toString() => 'NearbyMessage(type: $type, body: $body)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NearbyMessage && o.type == type && o.body == body;
  }

  @override
  int get hashCode => type.hashCode ^ body.hashCode;
}
