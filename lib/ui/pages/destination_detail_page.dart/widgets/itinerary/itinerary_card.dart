import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/checkpoint_images.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/itinerary_actions.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/common/gradient_container.dart';
import 'package:sahayatri/ui/widgets/image/adaptive_image.dart';

import 'package:sahayatri/locator.dart';

class ItineraryCard extends StatelessWidget {
  final bool deletable;
  final Itinerary itinerary;

  const ItineraryCard({
    super.key,
    this.deletable = false,
    required this.itinerary,
  });

  List<String> get imageUrls {
    String? getImageUrl(Checkpoint c) {
      if (c.place.imageUrls.isEmpty) return null;
      return c.place.imageUrls.first;
    }

    return itinerary.checkpoints
        .map(getImageUrl)
        .where((url) => url != null)
        .map((url) => url!)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: itinerary,
      child: GestureDetector(
        onTap: () => locator<DestinationNavService>()
            .pushNamed(Routes.itineraryPageRoute, arguments: itinerary),
        child: ElevatedCard(
          radius: 8.0,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              GradientContainer(
                alignment: Alignment.centerRight,
                gradientEnd: Alignment.topRight,
                gradientBegin: Alignment.centerLeft,
                child: _ImagesLayer(imageUrls: imageUrls),
                gradientColors: [
                  context.theme.cardColor,
                  context.theme.cardColor,
                  context.theme.cardColor.withOpacity(0.8),
                  context.theme.cardColor.withOpacity(0.5),
                  context.theme.cardColor.withOpacity(0.2),
                  context.theme.cardColor.withOpacity(0.0),
                ],
              ),
              _buildDetails(context),
              Positioned(
                top: 0.0,
                right: 0.0,
                child: ItineraryActions(itinerary: itinerary, deletable: deletable),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    final checkpointsLen = itinerary.checkpoints.length;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            checkpointsLen == 1 ? '1 checkpoint' : '$checkpointsLen checkpoints',
            style: context.t.titleLarge,
          ),
          const SizedBox(height: 6.0),
          CheckpointImages(imageUrls: imageUrls),
          const SizedBox(height: 10.0),
          Text(
            '${itinerary.days} days / ${itinerary.nights} nights',
            style: context.t.titleLarge?.bold,
          ),
          const SizedBox(height: 6.0),
          _buildTitleRow(context),
        ],
      ),
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Row(
      children: [
        Text(
          itinerary.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.t.headlineMedium,
        ),
        const Spacer(),
        if (!itinerary.isTemplate)
          ElevatedCard(
            radius: 16.0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              child: Text(
                '${itinerary.checkpoints.first.date} - ${itinerary.checkpoints.last.date}',
                style: AppTextStyles.headline6.primaryDark.bold,
              ),
            ),
          ),
      ],
    );
  }
}

class _ImagesLayer extends StatelessWidget {
  final List<String> imageUrls;

  const _ImagesLayer({
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    const height = 150.0;
    final width = MediaQuery.of(context).size.width * 0.8;
    final imagesLength = math.min(imageUrls.length, 6);
    final imageWidth = width / imagesLength;
    const offset = 32.0;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < imagesLength; ++i)
            Positioned(
              left: i * imageWidth + offset / 2.0,
              top: -offset,
              bottom: -offset,
              child: Transform.rotate(
                angle: math.pi / 16.0,
                child: AdaptiveImage(
                  imageUrls[i],
                  showLoading: false,
                  width: imageWidth - 3.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
