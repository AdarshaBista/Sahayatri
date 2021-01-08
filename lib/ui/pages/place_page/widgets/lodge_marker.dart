import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/map/markers/dynamic_text_marker.dart';

class LodgeMarker extends DynamicTextMarker {
  LodgeMarker({
    @required Lodge lodge,
  })  : assert(lodge != null),
        super(
          label: lodge.name,
          coord: lodge.coord,
          shrinkWhen: false,
          icon: AppIcons.lodges,
          onTap: (_) {
            locator<DestinationNavService>().pushNamed(
              Routes.lodgePageRoute,
              arguments: lodge,
            );
          },
        );
}
