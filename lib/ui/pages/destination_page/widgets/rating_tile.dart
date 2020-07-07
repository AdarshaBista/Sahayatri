import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/app/extensions/widget_x.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/widgets/column_button.dart';
import 'package:sahayatri/ui/shared/widgets/star_rating_bar.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/download_dialog.dart';

class RatingTile extends StatelessWidget {
  const RatingTile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          _buildRating(context),
          const Spacer(),
          _buildWeatherButton(context),
          const SizedBox(width: 12.0),
          _buildMoreButton(context),
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

  Widget _buildWeatherButton(BuildContext context) {
    final destination = context.bloc<DestinationBloc>().destination;

    return ColumnButton(
      label: 'Weather',
      onTap: () => context.repository<DestinationNavService>().pushNamed(
        Routes.kWeatherPageRoute,
        arguments: [
          destination.name,
          destination.startingPlace.coord,
        ],
      ),
      icon: CommunityMaterialIcons.weather_fog,
    );
  }

  Widget _buildMoreButton(BuildContext context) {
    final isDownloaded = context.bloc<DestinationBloc>().destination.isDownloaded;

    return ColumnButton(
      label: isDownloaded ? 'More' : 'Download',
      onTap: () => _downloadAndShowDetailPage(context),
      icon: isDownloaded
          ? CommunityMaterialIcons.forward
          : CommunityMaterialIcons.cloud_download_outline,
    );
  }

  Future<void> _downloadAndShowDetailPage(BuildContext context) async {
    if (!context.bloc<DestinationBloc>().state.destination.isDownloaded) {
      context.bloc<DestinationBloc>().add(const DestinationDownloaded());
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
