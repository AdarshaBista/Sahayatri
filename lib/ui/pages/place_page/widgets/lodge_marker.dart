import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class LodgeMarker extends Marker {
  LodgeMarker({
    @required Color color,
    @required Lodge lodge,
  })  : assert(color != null),
        assert(lodge != null),
        super(
          width: 100.0,
          height: 64.0,
          point: lodge.coord.toLatLng(),
          anchorPos: AnchorPos.align(AnchorAlign.top),
          builder: (context) => GestureDetector(
            onTap: () {
              context.repository<DestinationNavService>().pushNamed(
                    Routes.lodgePageRoute,
                    arguments: lodge,
                  );
            },
            child: ScaleAnimator(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        lodge.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.extraSmall.bold.light,
                      ),
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
          ),
        );
}
