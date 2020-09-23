import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/lodges_list.dart';

class CheckpointDetails extends StatelessWidget {
  final Checkpoint checkpoint;

  const CheckpointDetails({
    @required this.checkpoint,
  }) : assert(checkpoint != null);

  @override
  Widget build(BuildContext context) {
    return SlideAnimator(
      begin: const Offset(0.0, 0.5),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopRow(context),
            const Divider(height: 16.0, color: AppColors.disabled),
            _buildDescription(),
            const SizedBox(height: 16.0),
            _buildDateTime(),
            if (checkpoint.place.lodges.isNotEmpty) ...[
              Divider(height: 16.0, endIndent: MediaQuery.of(context).size.width / 2.0),
              LodgesList(lodges: checkpoint.place.lodges),
            ],
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRow(BuildContext context) {
    return Row(
      children: [
        Text(checkpoint.place.name, style: AppTextStyles.medium.bold),
        const Spacer(),
        GestureDetector(
          onTap: () => context.repository<DestinationNavService>().pushNamed(
                Routes.kPlacePageRoute,
                arguments: checkpoint.place,
              ),
          onDoubleTap: () => Navigator.of(context).pop(),
          child: Text(
            'VIEW',
            style: AppTextStyles.small.primary,
          ),
        ),
      ],
    );
  }

  Text _buildDescription() {
    return Text(
      checkpoint.description.isEmpty
          ? 'No description provided.'
          : checkpoint.description,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.small,
    );
  }

  Widget _buildDateTime() {
    return Row(
      children: [
        Text(
          checkpoint.time,
          style: AppTextStyles.small.primary.bold,
        ),
        const SizedBox(width: 8.0),
        const CircleAvatar(radius: 2.0),
        const SizedBox(width: 8.0),
        Text(
          checkpoint.date,
          style: AppTextStyles.extraSmall.primary,
        ),
      ],
    );
  }
}
