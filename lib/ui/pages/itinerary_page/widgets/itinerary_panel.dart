import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/checkpoint/notify_contact_status.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/image/image_card.dart';

import 'package:sahayatri/locator.dart';

class ItineraryPanel extends StatelessWidget {
  const ItineraryPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final itinerary = context.watch<Itinerary>();

    return Container(
      color: AppColors.darkFaded,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Text(
              itinerary.name.toUpperCase(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.headline1.light.withSize(36.0),
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Text(
              '${itinerary.checkpoints.first.date} - ${itinerary.checkpoints.last.date}'
                  .toUpperCase(),
              style: AppTextStyles.headline6.bold.primary,
            ),
          ),
          const SizedBox(height: 50.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Text(
              '${itinerary.checkpoints.length} CHECKPOINTS',
              style: AppTextStyles.headline5.light,
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            height: 240.0,
            child: ListView.builder(
              itemExtent: 220.0,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              itemCount: itinerary.checkpoints.length,
              itemBuilder: (context, index) {
                return _CheckpointCard(checkpoint: itinerary.checkpoints[index]);
              },
            ),
          ),
          const SizedBox(height: 64.0),
        ],
      ),
    );
  }
}

class _CheckpointCard extends StatelessWidget {
  final Checkpoint checkpoint;

  const _CheckpointCard({
    required this.checkpoint,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      radius: 12.0,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateTime(context),
          const SizedBox(height: 8.0),
          _buildDescription(context),
          const Divider(height: 16.0),
          _buildPlace(context),
          const SizedBox(height: 12.0),
          NotifyContactStatus(isNotified: checkpoint.notifyContact),
        ],
      ),
    );
  }

  Widget _buildDateTime(BuildContext context) {
    if (checkpoint.isTemplate) {
      return Text(
        'DAY ${checkpoint.day}',
        style: context.t.headlineSmall?.bold,
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          checkpoint.date.toUpperCase(),
          style: context.t.headlineSmall?.bold,
        ),
        const SizedBox(height: 4.0),
        Text(
          checkpoint.time.toUpperCase(),
          style: context.t.headlineSmall,
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    final text =
        checkpoint.description.isEmpty ? 'No description provided.' : checkpoint.description;
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        child: Text(
          text,
          style: context.t.headlineSmall,
        ),
      ),
    );
  }

  Widget _buildPlace(BuildContext context) {
    return GestureDetector(
      onTap: () {
        locator<DestinationNavService>().pushNamed(
          Routes.placePageRoute,
          arguments: checkpoint.place,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            checkpoint.place.name.toUpperCase(),
            style: context.t.titleLarge,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 72.0,
            child: Hero(
              tag: checkpoint.place.id,
              child: ImageCard(
                margin: EdgeInsets.zero,
                imageUrl: checkpoint.place.imageUrls.first,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
