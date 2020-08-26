import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/download_cubit/download_cubit.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:sahayatri/ui/pages/weather_page/weather_page.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/buttons/column_button.dart';
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
          _buildDownloadButton(context),
          const SizedBox(width: 12.0),
          _buildWeatherButton(context),
        ],
      ),
    );
  }

  Widget _buildRating(BuildContext context) {
    final rating = context.bloc<DestinationCubit>().destination.rating;

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
    final destination = context.bloc<DestinationCubit>().destination;

    return ColumnButton(
      label: 'Weather',
      icon: CommunityMaterialIcons.weather_fog,
      onTap: () => context.repository<DestinationNavService>().pushNamed(
            Routes.kWeatherPageRoute,
            arguments: WeatherPageArgs(
              name: destination.name,
              coord: destination.route.first,
            ),
          ),
    );
  }

  Widget _buildDownloadButton(BuildContext context) {
    if (!context.bloc<UserCubit>().isAuthenticated) return const Offstage();
    final destination = context.bloc<DestinationCubit>().destination;

    return destination.isDownloaded
        ? ColumnButton(
            label: 'Downloaded',
            icon: CommunityMaterialIcons.check_circle_outline,
            onTap: () {},
          )
        : ColumnButton(
            label: 'Download',
            icon: CommunityMaterialIcons.cloud_download_outline,
            onTap: () {
              context.bloc<DownloadCubit>().startDownload(destination);
              const DownloadDialog().openDialog(context, barrierDismissible: false);
            },
          );
  }
}
