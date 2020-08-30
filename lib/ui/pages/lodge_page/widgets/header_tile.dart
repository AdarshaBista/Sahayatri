import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/buttons/column_button.dart';
import 'package:sahayatri/ui/shared/widgets/star_rating_bar.dart';

class HeaderTile extends StatelessWidget {
  const HeaderTile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          _buildRating(context),
          const Spacer(),
          _buildViewRoomsButton(context),
        ],
      ),
    );
  }

  Widget _buildRating(BuildContext context) {
    final rating = context.watch<Lodge>().rating;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StarRatingBar(
          size: 20.0,
          rating: rating,
        ),
        const SizedBox(height: 4.0),
        Text(
          rating.toString(),
          style: AppTextStyles.large.bold,
        ),
      ],
    );
  }

  Widget _buildViewRoomsButton(BuildContext context) {
    return ColumnButton(
      label: 'View Rooms',
      icon: Icons.hotel_outlined,
      onTap: () => context
          .repository<DestinationNavService>()
          .pushNamed(Routes.kLodgeRoomsPageRoute),
    );
  }
}
