import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/star_rating_bar.dart';

class UpcomingLodgesList extends StatelessWidget {
  final List<Lodge> lodges;

  const UpcomingLodgesList({
    @required this.lodges,
  }) : assert(lodges != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Upcoming Lodges', style: AppTextStyles.small.light),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 80.0,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(width: 12.0),
            itemCount: lodges.length,
            itemBuilder: (_, index) => _buildItem(context, lodges[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, Lodge lodge) {
    return GestureDetector(
      onTap: () => context
          .repository<DestinationNavService>()
          .pushNamed(Routes.lodgePageRoute, arguments: lodge),
      child: Container(
        width: 180.0,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.light.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Text(
                lodge.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.small.bold.light,
              ),
            ),
            const SizedBox(height: 8.0),
            StarRatingBar(
              rating: lodge.rating,
              size: 12.0,
            ),
          ],
        ),
      ),
    );
  }
}
