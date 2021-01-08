import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/header.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';
import 'package:sahayatri/ui/widgets/buttons/circular_button.dart';
import 'package:sahayatri/ui/widgets/common/checkpoint_lodges.dart';

class CheckpointDetails extends StatelessWidget {
  final bool showLodges;
  final Checkpoint checkpoint;

  const CheckpointDetails({
    this.showLodges = true,
    @required this.checkpoint,
  })  : assert(checkpoint != null),
        assert(showLodges != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          const SizedBox(height: 4.0),
          const Divider(height: 12.0, indent: 20.0, endIndent: 20.0),
          const SizedBox(height: 4.0),
          _buildDescription(context),
          const SizedBox(height: 16.0),
          _CheckpointDateTime(checkpoint: checkpoint),
          if (showLodges && checkpoint.place.lodges.isNotEmpty) ...[
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
          color: AppColors.primary,
          backgroundColor: context.c.surface,
          onTap: () => locator<DestinationNavService>().pushNamed(
            Routes.placePageRoute,
            arguments: checkpoint.place,
          ),
        ),
        const SizedBox(width: 20.0),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          checkpoint.description.isEmpty
              ? 'No description provided.'
              : checkpoint.description,
          maxLines: 25,
          overflow: TextOverflow.ellipsis,
          style: context.t.headline5,
        ),
      ),
    );
  }
}

class _CheckpointDateTime extends StatelessWidget {
  final Checkpoint checkpoint;

  const _CheckpointDateTime({
    @required this.checkpoint,
  }) : assert(checkpoint != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          _buildCard(
            context: context,
            title: 'DATE',
            subtitle: checkpoint.date,
            icon: Icons.calendar_today_outlined,
          ),
          const SizedBox(width: 12.0),
          _buildCard(
            context: context,
            title: 'TIME',
            subtitle: checkpoint.time,
            icon: Icons.access_time,
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    BuildContext context,
    String title,
    IconData icon,
    String subtitle,
  }) {
    return Expanded(
      child: CustomCard(
        borderRadius: 12.0,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircularButton(
              icon: icon,
              color: context.c.primaryVariant,
              backgroundColor: AppColors.primaryLight,
            ),
            const SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.t.headline6,
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: context.t.headline5.bold,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
