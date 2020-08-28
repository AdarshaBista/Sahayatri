import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:sahayatri/core/services/tracker_service.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/adaptive_image.dart';
import 'package:sahayatri/ui/shared/widgets/elevated_card.dart';
import 'package:sahayatri/ui/shared/dialogs/message_dialog.dart';
import 'package:sahayatri/ui/shared/widgets/gradient_container.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class ItineraryCard extends StatelessWidget {
  final Itinerary itinerary;
  final bool deletable;

  const ItineraryCard({
    @required this.itinerary,
    this.deletable = false,
  })  : assert(itinerary != null),
        assert(deletable != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .repository<DestinationNavService>()
          .pushNamed(Routes.kItineraryPageRoute, arguments: itinerary),
      child: Container(
        height: 100.0,
        child: ElevatedCard(
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          child: Stack(
            children: [
              _buildBackground(),
              _buildTile(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return GradientContainer(
      gradientBegin: Alignment.centerLeft,
      gradientEnd: Alignment.centerRight,
      gradientColors: [
        AppColors.dark,
        AppColors.dark.withOpacity(0.5),
        Colors.transparent,
      ],
      child: AdaptiveImage(itinerary.checkpoints.first.place.imageUrls.first),
    );
  }

  Widget _buildTile(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      title: Text(
        itinerary.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.medium.light.bold,
      ),
      subtitle: _buildDetails(),
      trailing: ScaleAnimator(
        child: deletable ? _buildDeleteIcon(context) : _buildEditIcon(context),
      ),
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4.0),
        Text(
          '${itinerary.days} days ${itinerary.nights} nights',
          style: AppTextStyles.small.light.bold,
        ),
        const SizedBox(height: 4.0),
        Text(
          '${itinerary.checkpoints.length} checkpoints',
          style: AppTextStyles.extraSmall.primary,
        ),
      ],
    );
  }

  Widget _buildDeleteIcon(BuildContext context) {
    return _buildActionIcon(
      icon: Icons.close,
      color: AppColors.secondary,
      onTap: () {
        if (context.repository<TrackerService>().isTracking) {
          const MessageDialog(
            message: 'Cannot delete when tracker is running.',
          ).openDialog(context);
          return;
        }
        context.bloc<DestinationCubit>().deleteItinerary();
      },
    );
  }

  Widget _buildEditIcon(BuildContext context) {
    return _buildActionIcon(
      icon: Icons.edit,
      color: AppColors.primary,
      onTap: () => context.repository<DestinationNavService>().pushNamed(
            Routes.kItineraryFormPageRoute,
            arguments: itinerary,
          ),
    );
  }

  Widget _buildActionIcon({IconData icon, Color color, VoidCallback onTap}) {
    return CircleAvatar(
      radius: 16.0,
      backgroundColor: color,
      child: IconButton(
        onPressed: onTap,
        splashRadius: 16.0,
        icon: Icon(
          icon,
          size: 16.0,
          color: AppColors.dark,
        ),
      ),
    );
  }
}
