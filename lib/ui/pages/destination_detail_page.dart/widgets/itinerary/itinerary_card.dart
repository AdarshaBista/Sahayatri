import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/carousel.dart';
import 'package:sahayatri/ui/shared/widgets/elevated_card.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/checkpoint_images.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/itinerary_actions.dart';

class ItineraryCard extends StatelessWidget {
  static const double kCardHeight = 128.0;

  final bool deletable;
  final Itinerary itinerary;

  const ItineraryCard({
    this.deletable = false,
    @required this.itinerary,
  })  : assert(itinerary != null),
        assert(deletable != null);

  List<String> get imageUrls =>
      itinerary.checkpoints.map((c) => c.place.imageUrls.first).toList();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: itinerary,
      child: GestureDetector(
        onTap: () => context
            .repository<DestinationNavService>()
            .pushNamed(Routes.kItineraryPageRoute, arguments: itinerary),
        child: ElevatedCard(
          borderRadius: 8.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(),
              Expanded(child: _buildDetails()),
              ItineraryActions(itinerary: itinerary, deletable: deletable),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetails() {
    return Container(
      height: kCardHeight,
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            itinerary.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.small.bold,
          ),
          const SizedBox(height: 4.0),
          Text(
            '${itinerary.days} days / ${itinerary.nights} nights',
            style: AppTextStyles.extraSmall,
          ),
          const Divider(height: 10.0, endIndent: 80.0),
          Text(
            '${itinerary.checkpoints.length} checkpoints',
            style: AppTextStyles.extraSmall,
          ),
          const SizedBox(height: 6.0),
          CheckpointImages(imageUrls: imageUrls),
          const SizedBox(height: 8.0),
          if (!itinerary.isTemplate)
            Text(
              '${itinerary.checkpoints.first.date} - ${itinerary.checkpoints.last.date}',
              style: AppTextStyles.extraSmall.primary.bold,
            ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ElevatedCard(
      elevation: 0.0,
      borderRadius: 8.0,
      child: Carousel(
        width: 100.0,
        height: kCardHeight,
        imageUrls: imageUrls,
        showPagination: false,
      ),
    );
  }
}
