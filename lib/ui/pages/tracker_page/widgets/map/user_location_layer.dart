import 'package:flutter/material.dart';

import 'package:latlong/latlong.dart';
import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:provider/provider.dart';
import 'package:sahayatri/ui/widgets/map/markers/animated_latlng.dart';

class UserLocationLayer extends StatelessWidget {
  final bool repaintBoundary;
  final Widget Function(LatLng) builder;

  const UserLocationLayer({
    required this.builder,
    this.repaintBoundary = false,
  })  : assert(builder != null),
        assert(repaintBoundary != null);

  @override
  Widget build(BuildContext context) {
    final trackerUpdate = context.watch<TrackerUpdate>();
    final userTrack = trackerUpdate.userTrack;
    final coords = userTrack.map((t) => t.coord).toList();

    final end = coords.last;
    final begin = coords.length >= 2 ? coords[coords.length - 2] : coords.first;

    final child = AnimatedLatLng(
      begin: begin,
      end: end,
      builder: (point) => builder(point),
    );

    if (!repaintBoundary) return child;
    return RepaintBoundary(child: child);
  }
}
