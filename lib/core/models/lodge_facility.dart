import 'package:hive/hive.dart';

import 'package:sahayatri/core/constants/hive_config.dart';

part 'lodge_facility.g.dart';

@HiveType(typeId: HiveTypeIds.lodgeFacility)
class LodgeFacility {
  @HiveField(0)
  final bool wifi;

  @HiveField(1)
  final bool toilet;

  @HiveField(2)
  final bool shower;

  bool get isEmpty => !wifi && !toilet && !shower;

  const LodgeFacility({
    this.wifi = false,
    this.toilet = false,
    this.shower = false,
  });

  LodgeFacility copyWith({
    bool? wifi,
    bool? toilet,
    bool? shower,
  }) {
    return LodgeFacility(
      wifi: wifi ?? this.wifi,
      toilet: toilet ?? this.toilet,
      shower: shower ?? this.shower,
    );
  }

  factory LodgeFacility.parse(String str) {
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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LodgeFacility &&
        other.wifi == wifi &&
        other.toilet == toilet &&
        other.shower == shower;
  }

  @override
  int get hashCode => wifi.hashCode ^ toilet.hashCode ^ shower.hashCode;
}
