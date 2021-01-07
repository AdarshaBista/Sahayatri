import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/graphs/tracker_graph.dart';

class ElevationGraph extends StatelessWidget {
  const ElevationGraph();

  @override
  Widget build(BuildContext context) {
    final userTrack = context.watch<TrackerUpdate>().userTrack;
    final altitudes =
        userTrack.map((u) => double.parse(u.altitude.toStringAsFixed(1))).toList();

    return TrackerGraph(
      yValues: altitudes,
      color: Colors.blue,
      title: 'RECENT ELEVATION GAIN',
    );
  }
}
