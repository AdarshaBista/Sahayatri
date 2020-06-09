import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/carousel.dart';
import 'package:sahayatri/ui/shared/widgets/photo_gallery.dart';
import 'package:sahayatri/ui/shared/widgets/custom_button.dart';
import 'package:sahayatri/ui/shared/widgets/custom_appbar.dart';
import 'package:sahayatri/ui/shared/widgets/nested_tab_view.dart';
import 'package:sahayatri/ui/pages/place_page/widgets/place_stats.dart';
import 'package:sahayatri/ui/pages/place_page/widgets/lodges_grid.dart';

class PlacePage extends StatelessWidget {
  const PlacePage();

  @override
  Widget build(BuildContext context) {
    final place = Provider.of<Place>(context);

    return Scaffold(
      appBar: CustomAppbar(title: place.name),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          _buildCarousel(place),
          const SizedBox(height: 8.0),
          const PlaceStats(),
          const Divider(height: 16.0),
          _buildDescription(place),
          _buildWeatherButton(context, place),
          const Divider(height: 16.0),
          _buildTabView(place),
        ],
      ),
    );
  }

  Widget _buildCarousel(Place place) {
    return Hero(
      tag: place.id,
      child: Carousel(imageUrls: place.imageUrls),
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
        iconData: CommunityMaterialIcons.cloud_download_outline,
        onTap: () => context.repository<DestinationNavService>().pushNamed(
          Routes.kWeatherPageRoute,
          arguments: [
            place.name,
            place.coord,
          ],
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
