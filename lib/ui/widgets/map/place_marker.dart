import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:sahayatri/ui/widgets/map/text_marker.dart';

class PlaceMarker extends TextMarker {
  PlaceMarker({
    @required Place place,
    @required bool hideText,
  })  : assert(place != null),
        assert(hideText != null),
        super(
          text: place.name,
          color: Colors.red,
          coord: place.coord,
          hideText: hideText,
          onTap: (_) {
            locator<DestinationNavService>().pushNamed(
              Routes.placePageRoute,
              arguments: place,
            );
          },
        );
}
