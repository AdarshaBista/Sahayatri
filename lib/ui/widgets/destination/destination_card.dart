import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/extensions/dialog_extension.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/constants/images.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/downloaded_destinations_cubit/downloaded_destinations_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/icon_label.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/dialogs/confirm_dialog.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';
import 'package:sahayatri/ui/widgets/image/adaptive_image.dart';
import 'package:sahayatri/ui/widgets/common/star_rating_bar.dart';
import 'package:sahayatri/ui/widgets/common/gradient_container.dart';

class DestinationCard extends StatelessWidget {
  static const double borderRadius = 8.0;
  final bool deletable;
  final Destination destination;

  const DestinationCard({
    this.deletable = false,
    @required this.destination,
  })  : assert(deletable != null),
        assert(destination != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          locator<RootNavService>()
              .pushNamed(Routes.destinationPageRoute, arguments: destination);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              _buildBackground(),
              _buildDetails(),
              if (deletable) _buildDeleteIcon(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return CustomCard(
      borderRadius: borderRadius,
      child: GradientContainer(
        height: 180.0,
        gradientColors: AppColors.cardGradient,
        child: destination.imageUrls.isEmpty
            ? const AdaptiveImage(Images.authBackground)
            : AdaptiveImage(destination.imageUrls.first),
      ),
    );
  }

  Widget _buildDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconLabel(
            iconSize: 16.0,
            iconColor: AppColors.light,
            icon: deletable ? AppIcons.downloaded : AppIcons.destinations,
            label: destination.name.toUpperCase(),
            labelStyle: AppTextStyles.headline4.bold.light,
          ),
          const SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: Text(
              destination.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.headline6.lightAccent,
            ),
          ),
          Divider(
            height: 12.0,
            color: AppColors.lightAccent.withOpacity(0.5),
          ),
          _buildStats(),
        ],
      ),
    );
  }

  Widget _buildStats() {
    final separator = [
      const SizedBox(width: 8.0),
      const CircleAvatar(radius: 2.0, backgroundColor: AppColors.primary),
      const SizedBox(width: 8.0),
    ];

    return Row(
      children: [
        Text(
          '${destination.length} km',
          style: AppTextStyles.headline6.primary,
        ),
        ...separator,
        Text(
          '${destination.maxAltitude} m',
          style: AppTextStyles.headline6.primary,
        ),
        ...separator,
        Text(
          '${destination.estimatedDuration} days',
          style: AppTextStyles.headline6.primary,
        ),
        const Spacer(),
        StarRatingBar(
          rating: destination.rating,
          size: 12.0,
        ),
      ],
    );
  }

  Widget _buildDeleteIcon(BuildContext context) {
    return Positioned(
      top: 0.0,
      right: 0.0,
      child: GestureDetector(
        onTap: () => ConfirmDialog(
          message: 'Do you want to delete\n${destination.name}',
          onConfirm: () =>
              context.read<DownloadedDestinationsCubit>().delete(destination),
        ).openDialog(context),
        child: Container(
          width: 36.0,
          height: 36.0,
          decoration: const BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
            ),
          ),
          child: const Icon(
            AppIcons.delete,
            size: 18.0,
            color: AppColors.lightAccent,
          ),
        ),
      ),
    );
  }
}
