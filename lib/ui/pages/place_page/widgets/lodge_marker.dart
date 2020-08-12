import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/configs.dart';
import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class LodgeMarker extends Marker {
  LodgeMarker({
    @required Color color,
    @required Lodge lodge,
  })  : assert(color != null),
        assert(lodge != null),
        super(
          point: lodge.coord.toLatLng(),
          builder: (context) => GestureDetector(
            onTap: () {
              context.repository<DestinationNavService>().pushNamed(
                    Routes.kLodgePageRoute,
                    arguments: lodge,
                  );
            },
            child: ScaleAnimator(
              child: Image.asset(
                Images.kMarker,
                width: 24.0,
                height: 24.0,
                color: color,
              ),
            ),
          ),
        );
}
