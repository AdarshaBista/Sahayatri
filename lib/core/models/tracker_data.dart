import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';

import 'package:sahayatri/app/constants/hive_config.dart';

part 'tracker_data.g.dart';

@HiveType(typeId: HiveTypeIds.trackerData)
class TrackerData {
  @HiveField(0)
  final String destinationId;

  @HiveField(1)
  final int elapsed;

  @HiveField(2)
  final List<String> smsSentList;

  const TrackerData({
    this.destinationId,
    this.elapsed = 0,
    this.smsSentList = const [],
  })  : assert(elapsed != null),
        assert(smsSentList != null);

  TrackerData copyWith({
    int elapsed,
    String destinationId,
    List<String> smsSentList,
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
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TrackerData &&
        o.destinationId == destinationId &&
        o.elapsed == elapsed &&
        listEquals(o.smsSentList, smsSentList);
  }

  @override
  int get hashCode => destinationId.hashCode ^ elapsed.hashCode ^ smsSentList.hashCode;
}
