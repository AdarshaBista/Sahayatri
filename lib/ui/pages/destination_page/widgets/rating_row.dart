import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/app/extensions/widget_x.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/widgets/star_rating_bar.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/download_dialog.dart';

class RatingRow extends StatelessWidget {
  const RatingRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          _buildRating(context),
          const Spacer(),
          _buildDownloadButton(context),
        ],
      ),
    );
  }

  Widget _buildRating(BuildContext context) {
    final rating = context.bloc<DestinationBloc>().destination.rating;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StarRatingBar(
          rating: rating,
          size: 20.0,
        ),
        const SizedBox(height: 4.0),
        Text(
          rating.toString(),
          style: AppTextStyles.large.bold,
        ),
      ],
    );
  }

  Widget _buildDownloadButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _downloadAndNavigate(context),
      child: ScaleAnimator(
        child: Column(
          children: [
            const Icon(
              CommunityMaterialIcons.cloud_download_outline,
              size: 24.0,
            ),
            const SizedBox(height: 4.0),
            Text(
              'Download',
              style: AppTextStyles.small,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadAndNavigate(BuildContext context) async {
    if (!context.bloc<DestinationBloc>().state.destination.isDownloaded) {
      context.bloc<DestinationBloc>().add(DestinationDownloaded());
      DownloadDialog(
        title: context.bloc<DestinationBloc>().destination.name,
      ).openDialog(context);

      await Future.delayed(const Duration(seconds: 1));
      context.repository<DestinationNavService>().pop();
    }

    context
        .repository<DestinationNavService>()
        .pushNamed(Routes.kDestinationDetailPageRoute);
  }
}
