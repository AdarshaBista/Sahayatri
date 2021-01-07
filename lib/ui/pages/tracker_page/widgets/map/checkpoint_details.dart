import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/header.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';
import 'package:sahayatri/ui/widgets/buttons/circular_button.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/checkpoint_lodges.dart';

class CheckpointDetails extends StatelessWidget {
  final Checkpoint checkpoint;

  const CheckpointDetails({
    @required this.checkpoint,
  }) : assert(checkpoint != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          const Divider(height: 16.0),
          _buildDescription(context),
          const SizedBox(height: 12.0),
          _buildDateTime(context),
          if (checkpoint.place.lodges.isNotEmpty) ...[
            const SizedBox(height: 16.0),
            CheckpointLodges(lodges: checkpoint.place.lodges),
          ],
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Header(
          padding: 20.0,
          fontSize: 25.0,
          title: checkpoint.place.name,
        ),
        const Spacer(),
        CircularButton(
          icon: Icons.open_in_new_outlined,
          color: AppColors.primaryDark,
          backgroundColor: context.c.surface,
          onTap: () => locator<DestinationNavService>().pushNamed(
            Routes.placePageRoute,
            arguments: checkpoint.place,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        checkpoint.description.isEmpty
            ? 'No description provided.'
            : checkpoint.description,
        overflow: TextOverflow.ellipsis,
        style: context.t.headline5,
      ),
    );
  }

  Widget _buildDateTime(BuildContext context) {
    return CustomCard(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListTile(
        dense: true,
        title: Text(
          checkpoint.date,
          style: context.t.headline5.bold,
        ),
        leading: CircularButton(
          icon: Icons.access_time,
          color: context.c.primaryVariant,
          backgroundColor: AppColors.primaryLight,
        ),
        subtitle: Text(
          checkpoint.time,
          style: context.t.headline5,
        ),
      ),
    );
  }
}
