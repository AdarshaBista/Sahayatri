import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:sahayatri/core/models/checkpoint.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/checkpoint_details.dart';

class CheckpointMarker extends Marker {
  CheckpointMarker({
    @required Checkpoint checkpoint,
  })  : assert(checkpoint != null),
        super(
          width: 32,
          height: 32,
          point: checkpoint.place.coord.toLatLng(),
          anchorPos: AnchorPos.align(AnchorAlign.center),
          builder: (context) => GestureDetector(
            onTap: () {
              CheckpointDetails(checkpoint: checkpoint).openModalBottomSheet(context);
            },
            child: const ScaleAnimator(
              child: Icon(
                Icons.radio_button_checked,
                size: 28.0,
                color: AppColors.primaryDark,
              ),
            ),
          ),
        );
}
