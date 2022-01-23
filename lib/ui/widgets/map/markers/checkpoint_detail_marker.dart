import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/extensions/dialog_extension.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/image/adaptive_image.dart';
import 'package:sahayatri/ui/widgets/checkpoint/checkpoint_details.dart';
import 'package:sahayatri/ui/widgets/map/markers/arrow_marker_widget.dart';

class CheckpointDetailMarker extends Marker {
  CheckpointDetailMarker({
    bool isTracking = false,
    required Checkpoint checkpoint,
  })  : assert(isTracking != null),
        assert(checkpoint != null),
        super(
          width: 200.0,
          height: 72.0,
          anchorPos: AnchorPos.align(AnchorAlign.top),
          point: checkpoint.place.coord.toLatLng(),
          builder: (context) => ArrowMarkerWidget(
            borderRadius: 50.0,
            onTap: () {
              CheckpointDetails(
                showLodges: isTracking,
                checkpoint: checkpoint,
              ).openModalBottomSheet(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PlaceImage(imageUrl: checkpoint.place.imageUrls.first),
                Flexible(child: _CheckpointInfo(checkpoint: checkpoint)),
              ],
            ),
          ),
        );
}

class _PlaceImage extends StatelessWidget {
  final String imageUrl;

  const _PlaceImage({
    required this.imageUrl,
  }) : assert(imageUrl != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: AdaptiveImage(imageUrl),
    );
  }
}

class _CheckpointInfo extends StatelessWidget {
  final Checkpoint checkpoint;

  const _CheckpointInfo({
    required this.checkpoint,
  }) : assert(checkpoint != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 8.0, 16.0, 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            checkpoint.place.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.t.headline5,
          ),
          const SizedBox(height: 2.0),
          Text(
            '${checkpoint.date}, ${checkpoint.time}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.t.headline6.bold.withColor(AppColors.primaryDark),
          ),
        ],
      ),
    );
  }
}
