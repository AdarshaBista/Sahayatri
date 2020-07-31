import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/core/models/checkpoint.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';

class CheckpointDetailMarker extends Marker {
  CheckpointDetailMarker({
    @required Checkpoint checkpoint,
  })  : assert(checkpoint != null),
        super(
          width: 200,
          height: 64,
          anchorPos: AnchorPos.align(AnchorAlign.top),
          point: checkpoint.place.coord.toLatLng(),
          builder: (_) => Hero(
            tag: checkpoint.place.id,
            child: CustomCard(
              elevation: 8.0,
              color: AppColors.light,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _DateTimeInfo(checkpoint: checkpoint),
                  Flexible(child: _PlaceInfo(checkpoint: checkpoint)),
                ],
              ),
            ),
          ),
        );
}

class _DateTimeInfo extends StatelessWidget {
  final Checkpoint checkpoint;

  const _DateTimeInfo({
    @required this.checkpoint,
  }) : assert(checkpoint != null);

  @override
  Widget build(BuildContext context) {
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
}

class _PlaceInfo extends StatelessWidget {
  final Checkpoint checkpoint;

  const _PlaceInfo({
    @required this.checkpoint,
  }) : assert(checkpoint != null);

  @override
  Widget build(BuildContext context) {
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