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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Stack(
        children: [
          _buildCard(context),
          _buildImage(),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .repository<DestinationNavService>()
          .pushNamed(Routes.kItineraryPageRoute, arguments: itinerary),
      child: ElevatedCard(
        elevation: 8.0,
        borderRadius: 4.0,
        margin: const EdgeInsets.only(left: 12.0, top: 12.0),
        child: Container(
          height: kCardHeight,
          child: _buildDetails(),
          padding:
              const EdgeInsets.only(left: 104.0, top: 12.0, right: 36.0, bottom: 12.0),
        ),
      ),
    );
  }

  Widget _buildDetails() {
    return Column(
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
        const SizedBox(height: 6.0),
        if (!itinerary.isTemplate)
          Text(
            '${itinerary.checkpoints.first.date} - ${itinerary.checkpoints.last.date}',
            style: AppTextStyles.extraSmall.primary.bold,
          ),
      ],
    );
  }

  Widget _buildImage() {
    return ElevatedCard(
      elevation: 0.0,
      borderRadius: 4.0,
      child: Carousel(
        width: 100.0,
        height: kCardHeight,
        imageUrls: imageUrls,
        showPagination: false,
      ),
    );
  }

  Widget _buildActions() {
    return Positioned(
      top: 12.0,
      right: 0.0,
      child: ItineraryActions(
        itinerary: itinerary,
        deletable: deletable,
      ),
    );
  }
}
