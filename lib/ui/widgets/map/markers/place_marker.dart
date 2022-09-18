import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/map/markers/dynamic_text_marker.dart';

import 'package:sahayatri/locator.dart';

class PlaceMarker extends DynamicTextMarker {
  PlaceMarker({
    required Place place,
    required super.shrinkWhen,
  }) : super(
          icon: AppIcons.place,
          label: place.name,
          coord: place.coord,
          color: AppColors.light,
          backgroundColor: AppColors.secondary,
          onTap: (_) => locator<DestinationNavService>().pushNamed(
            Routes.placePageRoute,
            arguments: place,
          ),
        );
}
