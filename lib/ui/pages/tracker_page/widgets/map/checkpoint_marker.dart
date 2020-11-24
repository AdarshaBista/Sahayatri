import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/extensions/index.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/checkpoint_details.dart';

class CheckpointMarker extends Marker {
  CheckpointMarker({
    @required Checkpoint checkpoint,
  })  : assert(checkpoint != null),
        super(
          width: 28,
          height: 28,
          point: checkpoint.place.coord.toLatLng(),
          anchorPos: AnchorPos.align(AnchorAlign.top),
          builder: (context) => GestureDetector(
            onTap: () {
              CheckpointDetails(checkpoint: checkpoint).openModalBottomSheet(context);
            },
            child: const ScaleAnimator(
              child: Icon(
                CommunityMaterialIcons.map_marker_check,
                size: 28.0,
                color: AppColors.primaryDark,
              ),
            ),
          ),
        );
}
