import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';

class NextStopCard extends StatelessWidget {
  final Place place;

  const NextStopCard({
    @required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NEXT STOP',
            style: AppTextStyles.small.bold,
          ),
          const SizedBox(height: 12.0),
          CustomCard(
            padding: place != null
                ? const EdgeInsets.symmetric(vertical: 8.0)
                : const EdgeInsets.all(16.0),
            child: place != null ? _buildTile(context) : _buildNoNextStop(),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context) {
    return ListTile(
      title: Text(
        place.name,
        style: AppTextStyles.medium.bold,
      ),
      subtitle: Text(
        place.description,
        style: AppTextStyles.small,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      leading: CircleAvatar(backgroundImage: AssetImage(place.imageUrls[0])),
      onTap: () {
        context
            .repository<DestinationNavService>()
            .pushNamed(Routes.kPlacePageRoute, arguments: place);
      },
    );
  }

  Widget _buildNoNextStop() {
    return Row(
      children: [
        Text(
          'No next stop!',
          style: AppTextStyles.medium,
        ),
      ],
    );
  }
}
