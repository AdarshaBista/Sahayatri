import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:sahayatri/core/models/weather.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/stat_card.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

class WeatherDetail extends StatelessWidget {
  final Weather weather;

  const WeatherDetail({
    @required this.weather,
  }) : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLeftColumn(context),
          _buildRightColumn(context),
        ],
      ),
    );
  }

  Widget _buildLeftColumn(BuildContext context) {
    return SlideAnimator(
      begin: const Offset(0.5, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY).format(weather.date),
            style: context.t.headline4,
          ),
          const SizedBox(height: 16.0),
          Icon(
            weather.icon,
            size: 50.0,
          ),
          const SizedBox(height: 8.0),
          Text(
            weather.label.toUpperCase(),
            style: context.t.headline3.bold,
          ),
          _buildTemp(context),
          Text(
            'Feels like ${weather.feelsLikeTemp}°c',
            style: context.t.headline5,
          ),
          const Divider(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StatCard(
                label: 'Min',
                count: '${weather.minTemp}°',
                color: context.c.onSurface,
                countStyle: context.t.headline5,
              ),
              const SizedBox(width: 16.0),
              StatCard(
                label: 'Max',
                count: '${weather.maxTemp}°',
                color: context.c.onSurface,
                countStyle: context.t.headline5,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemp(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${weather.temp}',
          style: context.t.headline3.serif.withSize(96.0),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            '°',
            style: context.t.headline3.withSize(50.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            'C',
            style: context.t.headline2.withSize(40.0),
          ),
        ),
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context) {
    return SlideAnimator(
      begin: const Offset(-0.5, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          StatCard(
            label: 'Sunrise',
            count: DateFormat(DateFormat.HOUR_MINUTE).format(weather.sunrise),
            color: AppColors.primaryDark,
            countStyle: context.t.headline5,
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
          const SizedBox(height: 16.0),
          StatCard(
            label: 'Sunset',
            count: DateFormat(DateFormat.HOUR_MINUTE).format(weather.sunset),
            color: AppColors.primaryDark,
            countStyle: context.t.headline5,
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
          const SizedBox(height: 16.0),
          StatCard(
            label: 'Pressure',
            count: '${weather.pressure} hPa',
            color: AppColors.primaryDark,
            countStyle: context.t.headline5,
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
          const SizedBox(height: 16.0),
          StatCard(
            label: 'Humidity',
            count: '${weather.humidity}%',
            color: AppColors.primaryDark,
            countStyle: context.t.headline5,
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
          const SizedBox(height: 16.0),
          StatCard(
            label: 'Wind Speed',
            count: '${weather.windSpeed} m/s',
            color: AppColors.primaryDark,
            countStyle: context.t.headline5,
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
        ],
      ),
    );
  }
}
