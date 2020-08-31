import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/pages/weather_page/weather_page.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';
import 'package:sahayatri/ui/shared/widgets/photo_gallery.dart';
import 'package:sahayatri/ui/shared/widgets/nested_tab_view.dart';
import 'package:sahayatri/ui/shared/widgets/collapsible_carousel.dart';
import 'package:sahayatri/ui/pages/place_page/widgets/place_stats.dart';
import 'package:sahayatri/ui/pages/place_page/widgets/lodges_grid.dart';

class PlacePage extends StatelessWidget {
  const PlacePage();

  @override
  Widget build(BuildContext context) {
    final place = Provider.of<Place>(context, listen: false);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            CollapsibleCarousel(
              title: place.name,
              heroId: place.id,
              imageUrls: place.imageUrls,
            ),
          ];
        },
        body: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            if (place.description.isNotEmpty) _buildDescription(place),
            if (place.description.isNotEmpty) const Divider(height: 16.0),
            const PlaceStats(),
            _buildWeatherButton(context, place),
            const Divider(height: 16.0),
            _buildTabView(place),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(Place place) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 8.0,
      ),
      child: Text(
        place.description,
        style: AppTextStyles.small.serif,
      ),
    );
  }

  Widget _buildWeatherButton(BuildContext context, Place place) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: CustomButton(
        label: 'Weather',
        outlineOnly: true,
        color: AppColors.dark,
        iconData: CommunityMaterialIcons.weather_fog,
        onTap: () => context.repository<DestinationNavService>().pushNamed(
              Routes.kWeatherPageRoute,
              arguments: WeatherPageArgs(
                name: place.name,
                coord: place.coord,
              ),
            ),
      ),
    );
  }

  Widget _buildTabView(Place place) {
    return NestedTabView(
      tabs: [
        NestedTabData(label: 'Photos', icon: Icons.photo),
        NestedTabData(label: 'Lodges', icon: Icons.hotel),
      ],
      children: [
        PhotoGallery(imageUrls: place.imageUrls),
        const LodgesGrid(),
      ],
    );
  }
}
