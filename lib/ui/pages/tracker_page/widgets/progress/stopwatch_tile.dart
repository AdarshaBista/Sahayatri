import 'dart:async';

import 'package:flutter/material.dart';

import 'package:sahayatri/core/services/tracker/tracker_service.dart';
import 'package:sahayatri/core/services/tracker/stopwatch_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
    if (context.read<TrackerService>().isTracking) {
      setState(() {
        elapsed = context.read<StopwatchService>().elapsed();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.timer_outlined,
            size: 24.0,
            color: context.c.onSurface,
          ),
          const SizedBox(height: 2.0),
          Text(
            _formatDuration(elapsed),
            style: context.t.headline2.thin,
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    return [duration.inHours, duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }
}
