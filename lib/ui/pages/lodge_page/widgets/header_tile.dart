import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/common/star_rating_bar.dart';

class HeaderTile extends StatelessWidget {
  const HeaderTile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildRating(context),
          const SizedBox(height: 8.0),
          _buildViewRoomsButton(context),
        ],
      ),
    );
  }

  Widget _buildRating(BuildContext context) {
    final rating = context.select<Lodge, double>((l) => l.rating);

    return Row(
      children: [
        StarRatingBar(
          size: 20.0,
          rating: rating,
        ),
        const SizedBox(width: 8.0),
        Text(
          '($rating)',
          style: AppTextStyles.headline5.darkAccent,
        ),
      ],
    );
  }

  Widget _buildViewRoomsButton(BuildContext context) {
    return CustomButton(
      label: 'View Rooms',
      color: AppColors.dark,
      backgroundColor: AppColors.primaryLight,
      iconData: Icons.hotel_outlined,
      onTap: () =>
          context.read<DestinationNavService>().pushNamed(Routes.lodgeRoomsPageRoute),
    );
  }
}
