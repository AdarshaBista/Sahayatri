import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/core/models/checkpoint.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';

class CheckpointMarker extends StatelessWidget {
  final Checkpoint checkpoint;

  const CheckpointMarker({
    @required this.checkpoint,
  }) : assert(checkpoint != null);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: checkpoint.place.name,
      child: CustomCard(
        elevation: 8.0,
        color: AppColors.light,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDateTime(),
            Flexible(child: _buildPlace(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTime() {
    return Container(
      width: 60.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            checkpoint.place.imageUrls[0],
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            color: AppColors.barrier,
            colorBlendMode: BlendMode.srcATop,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                checkpoint.date,
                style: AppTextStyles.small.light.bold,
              ),
              const SizedBox(height: 4.0),
              Text(
                checkpoint.time,
                style: AppTextStyles.extraSmall.light,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlace(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: GestureDetector(
        onTap: () => context.repository<DestinationNavService>().pushNamed(
              Routes.kPlacePageRoute,
              arguments: checkpoint.place,
            ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                checkpoint.place.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.small.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Flexible(
              child: Text(
                checkpoint.description.isEmpty
                    ? 'No description provided'
                    : checkpoint.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.extraSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
