import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/pages/weather_page/weather_page.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/star_rating_bar.dart';
import 'package:sahayatri/ui/widgets/buttons/vertical_button.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/download_button.dart';

class HeaderTile extends StatelessWidget {
  const HeaderTile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          _buildRating(context),
          const Spacer(),
          const DownloadButton(),
          const SizedBox(width: 12.0),
          _buildWeatherButton(context),
          const SizedBox(width: 4.0),
        ],
      ),
    );
  }

  Widget _buildRating(BuildContext context) {
    final destination = context.watch<Destination>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StarRatingBar(
          rating: destination.rating,
          size: 20.0,
        ),
        const SizedBox(height: 4.0),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            destination.rating.toString(),
            style: context.t.headline3?.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherButton(BuildContext context) {
    final destination = context.watch<Destination>();

    return VerticalButton(
      label: 'Weather',
      icon: AppIcons.weather,
      onTap: () => locator<DestinationNavService>().pushNamed(
        Routes.weatherPageRoute,
        arguments: WeatherPageArgs(
          name: destination.name,
          coord: destination.route.first,
        ),
      ),
    );
  }
}
