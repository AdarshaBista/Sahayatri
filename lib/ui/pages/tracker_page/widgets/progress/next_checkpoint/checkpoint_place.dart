import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/models/tracker_update.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/circular_button.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';

import 'package:sahayatri/locator.dart';

class CheckpointPlace extends StatelessWidget {
  const CheckpointPlace({super.key});

  @override
  Widget build(BuildContext context) {
    final place = context.watch<TrackerUpdate>().nextCheckpoint!.checkpoint.place;

    return GestureDetector(
      onTap: () {
        locator<DestinationNavService>().pushNamed(
          Routes.placePageRoute,
          arguments: place,
        );
      },
      child: Hero(
        tag: place.id,
        child: CustomCard(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          borderRadius: 12.0,
          child: ListTile(
            dense: true,
            title: Text(
              place.name.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.t.headlineSmall?.bold,
            ),
            leading: CircularButton(
              icon: AppIcons.place,
              backgroundColor: AppColors.primaryLight,
              color: context.c.primaryContainer,
            ),
            subtitle: Text(
              '${place.coord.alt.toStringAsFixed(0)} m',
              style: context.t.titleLarge?.bold,
            ),
          ),
        ),
      ),
    );
  }
}
