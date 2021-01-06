import 'dart:async';

import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/utils/format_utils.dart';
import 'package:sahayatri/core/services/tracker/tracker_service.dart';
import 'package:sahayatri/core/services/tracker/stopwatch_service.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class StopwatchTile extends StatefulWidget {
  const StopwatchTile();

  @override
  _StopwatchTileState createState() => _StopwatchTileState();
}

class _StopwatchTileState extends State<StopwatchTile> {
  Timer timer;
  Duration elapsed;

  @override
  void initState() {
    super.initState();
    updateTimer();
    timer = Timer.periodic(const Duration(seconds: 1), (_) => updateTimer());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void updateTimer() {
    if (locator<TrackerService>().isTracking) {
      setState(() {
        elapsed = locator<StopwatchService>().elapsed();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.access_time,
            size: 20.0,
            color: context.c.onSurface,
          ),
          const SizedBox(height: 4.0),
          Text(
            FormatUtils.time(elapsed),
            style: context.t.headline2,
          ),
        ],
      ),
    );
  }
}
