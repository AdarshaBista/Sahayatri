import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/tracker_bloc/tracker_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';

class StopwatchTile extends StatefulWidget {
  const StopwatchTile();

  @override
  _StopwatchTileState createState() => _StopwatchTileState();
}

class _StopwatchTileState extends State<StopwatchTile> {
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = context.bloc<TrackerBloc>().trackerService.elapsedDuration();

    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        const SizedBox(width: 8.0),
        Icon(
          CommunityMaterialIcons.clock_check_outline,
          color: AppColors.barrier,
          size: 22.0,
        ),
        const SizedBox(width: 8.0),
        Text(
          _formatDuration(elapsed),
          style: AppTextStyles.large.bold,
        ),
        const SizedBox(width: 8.0),
        Text(
          'elapsed',
          style: AppTextStyles.small,
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    return [duration.inHours, duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }
}
