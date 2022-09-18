import 'dart:async';

import 'package:flutter/material.dart';

import 'package:sahayatri/core/services/tracker/stopwatch_service.dart';
import 'package:sahayatri/core/services/tracker/tracker_service.dart';
import 'package:sahayatri/core/utils/format_utils.dart';

import 'package:sahayatri/ui/styles/styles.dart';

import 'package:sahayatri/locator.dart';

class StopwatchTile extends StatefulWidget {
  const StopwatchTile({super.key});

  @override
  State<StopwatchTile> createState() => _StopwatchTileState();
}

class _StopwatchTileState extends State<StopwatchTile> {
  late final Timer timer;
  late Duration elapsed;

  @override
  void initState() {
    super.initState();
    elapsed = locator<StopwatchService>().elapsed();
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
            AppIcons.timer,
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
