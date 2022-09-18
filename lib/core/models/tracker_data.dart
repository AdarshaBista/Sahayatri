import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';

import 'package:sahayatri/core/constants/hive_config.dart';

part 'tracker_data.g.dart';

@HiveType(typeId: HiveTypeIds.trackerData)
class TrackerData {
  @HiveField(0)
  final String? destinationId;

  @HiveField(1)
  final int elapsed;

  @HiveField(2)
  final List<String> smsSentList;

  const TrackerData({
    this.destinationId = '',
    this.elapsed = 0,
    this.smsSentList = const [],
  });

  TrackerData copyWith({
    int? elapsed,
    String? destinationId,
    List<String>? smsSentList,
  }) {
    return TrackerData(
      elapsed: elapsed ?? this.elapsed,
      smsSentList: smsSentList ?? this.smsSentList,
      destinationId: destinationId ?? this.destinationId,
    );
  }

  @override
  String toString() =>
      'TrackerData(destinationId: $destinationId, elapsed: $elapsed, smsSentList: $smsSentList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TrackerData &&
        other.destinationId == destinationId &&
        other.elapsed == elapsed &&
        listEquals(other.smsSentList, smsSentList);
  }

  @override
  int get hashCode => destinationId.hashCode ^ elapsed.hashCode ^ smsSentList.hashCode;
}
