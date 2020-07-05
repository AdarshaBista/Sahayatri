import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/tracker_bloc/tracker_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:community_material_icon/community_material_icon.dart';

class TrackerActions extends StatelessWidget {
  const TrackerActions();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: AppColors.secondary,
      child: ListTile(
        dense: true,
        isThreeLine: true,
        leading: const Icon(
          CommunityMaterialIcons.hand_left,
          color: AppColors.light,
          size: 36.0,
        ),
        title: Text(
          'STOP TRACKING',
          style: AppTextStyles.small.light.bold,
        ),
        subtitle: Text(
          'You will stop receiving tracking updates.',
          style: AppTextStyles.extraSmall.extraLight,
        ),
        onTap: () {
          context.repository<TrackerBloc>().add(const TrackingStopped());
        },
      ),
    );
  }
}
