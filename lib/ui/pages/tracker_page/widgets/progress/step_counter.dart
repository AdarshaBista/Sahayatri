import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:provider/provider.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';

class StepCounter extends StatelessWidget {
  const StepCounter();

  @override
  Widget build(BuildContext context) {
    final trackerUpdate = context.watch<TrackerUpdate>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Icon(
            CommunityMaterialIcons.walk,
            size: 20.0,
            color: AppColors.barrier,
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          trackerUpdate.steps.toString(),
          style: AppTextStyles.extraLarge.bold,
        ),
        const SizedBox(width: 8.0),
        Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Text(
            'steps walked',
            style: AppTextStyles.extraSmall,
          ),
        ),
      ],
    );
  }
}
