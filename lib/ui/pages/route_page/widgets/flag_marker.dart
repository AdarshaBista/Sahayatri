import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class FlagMarker extends Marker {
  FlagMarker({
    @required Color color,
    @required Coord coord,
  })  : assert(color != null),
        super(
          point: coord.toLatLng(),
          anchorPos: AnchorPos.align(AnchorAlign.top),
          builder: (context) => ScaleAnimator(
            child: Icon(
              CommunityMaterialIcons.flag_checkered,
              size: 24.0,
              color: color,
            ),
          ),
        );
}
