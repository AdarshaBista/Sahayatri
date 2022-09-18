import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/map/markers/dynamic_text_marker.dart';

import 'package:sahayatri/locator.dart';

class LodgeMarker extends DynamicTextMarker {
  LodgeMarker({
    required Lodge lodge,
  }) : super(
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
