import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/extensions/index.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/map/markers/dynamic_text_marker.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/checkpoint_details.dart';

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
          icon: CommunityMaterialIcons.map_marker_check,
          onTap: (context) {
            CheckpointDetails(checkpoint: checkpoint).openModalBottomSheet(context);
          },
        );
}
