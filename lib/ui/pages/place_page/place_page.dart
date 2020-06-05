import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/carousel.dart';
import 'package:sahayatri/ui/shared/widgets/photo_gallery.dart';
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
          Hero(
            tag: place.id,
            child: Carousel(imageUrls: place.imageUrls),
          ),
          const SizedBox(height: 8.0),
          const PlaceStats(),
          const Divider(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 8.0,
            ),
            child: Text(
              place.description,
              style: AppTextStyles.small.serif,
            ),
          ),
          const Divider(height: 16.0),
          NestedTabView(
            tabs: [
              NestedTabData(label: 'Photos', icon: Icons.photo),
              NestedTabData(label: 'Lodges', icon: Icons.hotel),
            ],
            children: [
              PhotoGallery(imageUrls: place.imageUrls),
              const LodgesGrid(),
            ],
          ),
        ],
      ),
    );
  }
}
