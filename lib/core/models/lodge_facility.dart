class LodgeFacility {
  final bool wifi;
  final bool toilet;
  final bool shower;

  bool get isEmpty => !wifi && !toilet && !shower;

  const LodgeFacility({
    this.wifi = false,
    this.toilet = false,
    this.shower = false,
  })  : assert(wifi != null),
        assert(toilet != null),
        assert(shower != null);

  LodgeFacility copyWith({
    bool wifi,
    bool toilet,
    bool shower,
  }) {
    return LodgeFacility(
      wifi: wifi ?? this.wifi,
      toilet: toilet ?? this.toilet,
      shower: shower ?? this.shower,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'wifi': wifi,
      'toilet': toilet,
      'shower': shower,
    };
  }

  factory LodgeFacility.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return LodgeFacility(
      wifi: map['wifi'] as bool,
      toilet: map['toilet'] as bool,
      shower: map['shower'] as bool,
    );
  }

  @override
  String toString() => 'LodgeFacility(wifi: $wifi, toilet: $toilet, shower: $shower)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LodgeFacility &&
        o.wifi == wifi &&
        o.toilet == toilet &&
        o.shower == shower;
  }

  @override
  int get hashCode => wifi.hashCode ^ toilet.hashCode ^ shower.hashCode;
}
