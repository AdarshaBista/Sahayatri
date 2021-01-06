import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/tracker_update.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/widgets/buttons/circular_button.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';

class CheckpointPlace extends StatelessWidget {
  const CheckpointPlace();

  @override
  Widget build(BuildContext context) {
    final place =
        context.select<TrackerUpdate, Place>((u) => u.nextCheckpoint.checkpoint.place);

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
          borderRadius: 12.0,
          child: ListTile(
            dense: true,
            title: Text(
              place.name.toUpperCase(),
              style: context.t.headline5.bold,
            ),
            leading: CircularButton(
              onTap: () {},
              icon: CommunityMaterialIcons.map_marker_check_outline,
              backgroundColor: AppColors.primaryLight,
              color: context.c.primaryVariant,
            ),
            subtitle: Text(
              '${place.coord.alt.toStringAsFixed(0)} m',
              style: context.t.headline6.bold,
            ),
          ),
        ),
      ),
    );
  }
}
