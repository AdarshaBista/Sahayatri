import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class FlagMarker extends Marker {
  FlagMarker({
    @required Color color,
    @required Coord coord,
    @required String label,
  })  : assert(color != null),
        super(
          width: 64.0,
          height: 64.0,
          point: coord.toLatLng(),
          anchorPos: AnchorPos.align(AnchorAlign.top),
          builder: (context) => ScaleAnimator(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    label,
                    style: AppTextStyles.extraSmall.bold.light,
                  ),
                ),
                const SizedBox(height: 2.0),
                Icon(
                  CommunityMaterialIcons.map_marker,
                  size: 28.0,
                  color: color,
                ),
              ],
            ),
          ),
        );
}
