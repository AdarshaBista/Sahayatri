import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/common/adaptive_image.dart';

class CheckpointDetailMarker extends Marker {
  CheckpointDetailMarker({
    @required Color color,
    @required Checkpoint checkpoint,
  })  : assert(checkpoint != null),
        super(
          width: 200,
          height: 64,
          anchorPos: AnchorPos.align(AnchorAlign.center),
          point: checkpoint.place.coord.toLatLng(),
          builder: (_) => Hero(
            tag: checkpoint.place.id,
            child: ElevatedCard(
              child: Material(
                color: color,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _DateTimeInfo(checkpoint: checkpoint),
                    Flexible(child: _PlaceInfo(checkpoint: checkpoint)),
                  ],
                ),
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
    return SizedBox(
      width: 60.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ElevatedCard(
            color: AppColors.darkSurface,
            child: AdaptiveImage(
              checkpoint.place.imageUrls[0],
              showLoading: false,
              color: AppColors.darkFaded,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                checkpoint.date,
                style: AppTextStyles.headline5.light.bold,
              ),
              const SizedBox(height: 4.0),
              Text(
                checkpoint.time,
                style: AppTextStyles.headline6.light,
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
        behavior: HitTestBehavior.opaque,
        onTap: () => locator<DestinationNavService>().pushNamed(
          Routes.placePageRoute,
          arguments: checkpoint.place,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Text(
                checkpoint.place.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.t.headline5.bold,
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
                style: context.t.headline6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
