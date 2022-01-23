import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/image/photo_gallery.dart';
import 'package:sahayatri/ui/widgets/views/nested_tab_view.dart';
import 'package:sahayatri/ui/widgets/views/collapsible_view.dart';
import 'package:sahayatri/ui/widgets/appbars/collapsible_carousel.dart';
import 'package:sahayatri/ui/pages/place_page/widgets/place_stats.dart';
import 'package:sahayatri/ui/pages/place_page/widgets/lodges_list.dart';
import 'package:sahayatri/ui/pages/place_page/widgets/place_actions.dart';

class PlacePage extends StatelessWidget {
  const PlacePage();

  @override
  Widget build(BuildContext context) {
    final place = context.watch<Place>();

    return Scaffold(
      body: CollapsibleView(
        collapsible: CollapsibleCarousel(
          title: place.name,
          heroId: place.id,
          imageUrls: place.imageUrls,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            if (place.description.isNotEmpty) _buildDescription(context, place),
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

  Widget _buildDescription(BuildContext context, Place place) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        place.description,
        style: context.t.headline5?.serif,
      ),
    );
  }

  Widget _buildTabView(Place place) {
    return NestedTabView(
      tabs: [
        NestedTabData(label: 'Photos', icon: AppIcons.photos),
        NestedTabData(label: 'Lodges', icon: AppIcons.lodges),
      ],
      children: [
        PhotoGallery(imageUrls: place.imageUrls),
        const LodgesList(),
      ],
    );
  }
}
