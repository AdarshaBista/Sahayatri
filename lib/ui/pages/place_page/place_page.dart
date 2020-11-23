import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/photo_gallery.dart';
import 'package:sahayatri/ui/widgets/common/nested_tab_view.dart';
import 'package:sahayatri/ui/widgets/common/collapsible_carousel.dart';
import 'package:sahayatri/ui/pages/place_page/widgets/place_stats.dart';
import 'package:sahayatri/ui/pages/place_page/widgets/lodges_grid.dart';
import 'package:sahayatri/ui/pages/place_page/widgets/place_actions.dart';

class PlacePage extends StatelessWidget {
  const PlacePage();

  @override
  Widget build(BuildContext context) {
    final place = context.watch<Place>();

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
            if (place.description.isNotEmpty) const SizedBox(height: 12.0),
            const PlaceActions(),
            const SizedBox(height: 8.0),
            const PlaceStats(),
            const Divider(height: 12.0, indent: 20.0, endIndent: 20.0),
            _buildTabView(place),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(Place place) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        place.description,
        style: AppTextStyles.headline5.serif,
      ),
    );
  }

  Widget _buildTabView(Place place) {
    return NestedTabView(
      tabs: [
        NestedTabData(label: 'Photos', icon: Icons.photo_outlined),
        NestedTabData(label: 'Lodges', icon: Icons.house_outlined),
      ],
      children: [
        PhotoGallery(imageUrls: place.imageUrls),
        const LodgesGrid(),
      ],
    );
  }
}
