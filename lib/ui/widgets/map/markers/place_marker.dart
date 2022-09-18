import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/map/markers/dynamic_text_marker.dart';

import 'package:sahayatri/locator.dart';

class PlaceMarker extends DynamicTextMarker {
  PlaceMarker({
    required Place place,
    required bool shrinkWhen,
  }) : super(
          icon: AppIcons.place,
          label: place.name,
          coord: place.coord,
          shrinkWhen: shrinkWhen,
          color: AppColors.light,
          backgroundColor: AppColors.secondary,
          onTap: (_) => locator<DestinationNavService>().pushNamed(
            Routes.placePageRoute,
            arguments: place,
          ),
        );
}
