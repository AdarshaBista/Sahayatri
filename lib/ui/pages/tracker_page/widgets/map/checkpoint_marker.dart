import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/extensions/dialog_extension.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/checkpoint/checkpoint_details.dart';
import 'package:sahayatri/ui/widgets/map/markers/dynamic_text_marker.dart';

class CheckpointMarker extends DynamicTextMarker {
  CheckpointMarker({
    @required Checkpoint checkpoint,
  })  : assert(checkpoint != null),
        super(
          shrinkWhen: false,
          color: AppColors.light,
          label: checkpoint.place.name,
          coord: checkpoint.place.coord,
          backgroundColor: AppColors.primaryDark,
          icon: AppIcons.checkpoint,
          onTap: (context) {
            CheckpointDetails(checkpoint: checkpoint).openModalBottomSheet(context);
          },
        );
}
