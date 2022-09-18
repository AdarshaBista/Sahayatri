import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/checkpoint/notify_contact_status.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';

class CheckpointInfo extends StatelessWidget {
  const CheckpointInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final checkpoint = context.watch<TrackerUpdate>().nextCheckpoint!.checkpoint;

    return SizedBox(
      height: 192.0,
      child: CustomCard(
        borderRadius: 12.0,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateTime(context, checkpoint),
            const Divider(height: 12.0),
            _buildDescription(context, checkpoint.description),
            const SizedBox(height: 8.0),
            NotifyContactStatus(isNotified: checkpoint.notifyContact),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTime(BuildContext context, Checkpoint checkpoint) {
    return Row(
      children: [
        Text(
          checkpoint.date,
          style: context.t.headline5?.primaryDark.bold,
        ),
        const SizedBox(width: 8.0),
        const CircleAvatar(radius: 2.0),
        const SizedBox(width: 8.0),
        Text(
          checkpoint.time,
          style: context.t.headline5?.primaryDark,
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context, String desc) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Text(
          desc.isEmpty ? 'No description provided.' : desc,
          style: context.t.headline5,
        ),
      ),
    );
  }
}
