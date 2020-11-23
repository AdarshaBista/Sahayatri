import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:sahayatri/ui/pages/weather_page/weather_page.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/column_button.dart';
import 'package:sahayatri/ui/widgets/common/star_rating_bar.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/download_button.dart';

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
          const DownloadButton(),
          const SizedBox(width: 12.0),
          _buildWeatherButton(context),
        ],
      ),
    );
  }

  Widget _buildRating(BuildContext context) {
    final rating =
        context.select<DestinationCubit, double>((dc) => dc.destination.rating);

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
          style: context.t.headline3.bold,
        ),
      ],
    );
  }

  Widget _buildWeatherButton(BuildContext context) {
    final destination =
        context.select<DestinationCubit, Destination>((dc) => dc.destination);

    return ColumnButton(
      label: 'Weather',
      icon: CommunityMaterialIcons.weather_fog,
      onTap: () => context.read<DestinationNavService>().pushNamed(
            Routes.weatherPageRoute,
            arguments: WeatherPageArgs(
              name: destination.name,
              coord: destination.route.first,
            ),
          ),
    );
  }
}
