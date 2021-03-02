import 'package:flutter/material.dart';

import 'package:latlong/latlong.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/tracker_update.dart';
import 'package:sahayatri/core/extensions/route_extension.dart';

import 'package:provider/provider.dart';
import 'package:sahayatri/ui/widgets/map/markers/animated_latlng.dart';

class UserLocationLayer extends StatelessWidget {
  final bool repaintBoundary;
  final Widget Function(LatLng) builder;

  const UserLocationLayer({
    @required this.builder,
    this.repaintBoundary = false,
  })  : assert(builder != null),
        assert(repaintBoundary != null);

  @override
  Widget build(BuildContext context) {
    final trackerUpdate = context.watch<TrackerUpdate>();
    final userTrack = trackerUpdate.userTrack;

    final zoom = Provider.of<double>(context, listen: false);
    final coords = userTrack.map((t) => t.coord).toList().simplify(zoom);

    final end = coords.last;
    Coord begin;
    if (coords.length >= 2) {
      begin = coords[coords.length - 2];
    } else {
      begin = coords.first;
    }

    final child = AnimatedLatLng(
      begin: begin,
      end: end,
      builder: (point) => builder(point),
    );

    if (!repaintBoundary) return child;
    return RepaintBoundary(child: child);
  }
}
