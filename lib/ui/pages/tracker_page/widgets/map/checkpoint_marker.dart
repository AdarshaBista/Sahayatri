import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';
import 'package:community_material_icon/community_material_icon.dart';

class CheckpointMarker extends Marker {
  CheckpointMarker({
    @required Place place,
  })  : assert(place != null),
        super(
          width: 32,
          height: 32,
          point: place.coord.toLatLng(),
          anchorPos: AnchorPos.align(AnchorAlign.top),
          builder: (context) => GestureDetector(
            onTap: () {
              context.repository<DestinationNavService>().pushNamed(
                    Routes.kPlacePageRoute,
                    arguments: place,
                  );
            },
            child: const ScaleAnimator(
              child: Icon(
                CommunityMaterialIcons.map_marker,
                size: 32.0,
                color: AppColors.secondary,
              ),
            ),
          ),
        );
}
