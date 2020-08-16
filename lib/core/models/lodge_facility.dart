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

  factory LodgeFacility.parse(String str) {
    if (str == null) return null;
    final List<String> values = str.split(',');

    return LodgeFacility(
      wifi: values.contains('wifi'),
      toilet: values.contains('toilet'),
      shower: values.contains('shower'),
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