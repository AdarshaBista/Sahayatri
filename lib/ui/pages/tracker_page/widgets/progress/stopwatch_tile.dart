import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/tracker_cubit/tracker_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';

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
    final elapsed = context.bloc<TrackerCubit>().elapsed;

    return Row(
      children: [
        Icon(
          CommunityMaterialIcons.clock_outline,
          color: AppColors.barrier,
          size: 20.0,
        ),
        const SizedBox(width: 8.0),
        Text(
          _formatDuration(elapsed),
          style: AppTextStyles.extraLarge.thin,
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
