class NearbyMessage {
  final String type;
  final String body;

  const NearbyMessage({
    required this.type,
    required this.body,
  });

  @override
  String toString() => 'NearbyMessage(type: $type, body: $body)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NearbyMessage && other.type == type && other.body == body;
  }

  @override
  int get hashCode => type.hashCode ^ body.hashCode;
}
