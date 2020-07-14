import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/resources.dart';
import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class PlaceMarker extends Marker {
  PlaceMarker({
    @required Color color,
    @required Place place,
  })  : assert(color != null),
        assert(place != null),
        super(
          point: place.coord.toLatLng(),
          builder: (context) => GestureDetector(
            onTap: () {
              context.repository<DestinationNavService>().pushNamed(
                    Routes.kPlacePageRoute,
                    arguments: place,
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
