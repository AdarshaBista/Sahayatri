import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
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
        context.repository<DestinationNavService>().pushNamed(
              Routes.kPlacePageRoute,
              arguments: place,
            );
      },
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
    );
  }

  Widget _buildBackground() {
    return Hero(
      tag: place.id,
      child: GradientContainer(
        gradientColors: [
          Colors.transparent,
          AppColors.dark.withOpacity(0.2),
          AppColors.dark.withOpacity(0.6),
          AppColors.dark.withOpacity(0.8),
        ],
        child: AdaptiveImage(place.imageUrls[0]),
      ),
    );
  }

  Widget _buildDetails() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            place.name.toUpperCase(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.small.bold.light,
          ),
          const SizedBox(height: 4.0),
          Text(
            '${place.coord.alt.toInt()} m',
            style: AppTextStyles.extraSmall.primary,
          ),
        ],
      ),
    );
  }
}
