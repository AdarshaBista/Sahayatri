import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/icon_label.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/common/adaptive_image.dart';
import 'package:sahayatri/ui/widgets/common/gradient_container.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard({
    @required this.place,
  }) : assert(place != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        locator<DestinationNavService>().pushNamed(
          Routes.placePageRoute,
          arguments: place,
        );
      },
      child: Hero(
        tag: place.id,
        child: ElevatedCard(
          radius: 8.0,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              _buildBackground(),
              _buildDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return GradientContainer(
      gradientColors: [AppColors.darkFaded, AppColors.darkFaded],
      child: AdaptiveImage(place.imageUrls[0]),
    );
  }

  Widget _buildDetails() {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${place.coord.alt.toInt()} m',
              style: AppTextStyles.headline6.primary,
            ),
            const SizedBox(height: 4.0),
            IconLabel(
              icon: Icons.location_on_outlined,
              label: place.name.toUpperCase(),
              iconColor: AppColors.light,
              labelStyle: AppTextStyles.headline5.bold.light,
            ),
          ],
        ),
      ),
    );
  }
}
