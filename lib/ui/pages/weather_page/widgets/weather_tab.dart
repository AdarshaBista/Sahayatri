import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:sahayatri/core/models/weather.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class WeatherTab extends StatelessWidget {
  final Color color;
  final bool isToday;
  final Weather weather;

  const WeatherTab({
    @required this.color,
    @required this.isToday,
    @required this.weather,
  })  : assert(color != null),
        assert(isToday != null),
        assert(weather != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isToday
                ? 'TODAY'
                : DateFormat(DateFormat.ABBR_WEEKDAY).format(weather.date).toUpperCase(),
            style: AppTextStyles.headline4.withColor(color),
          ),
          const SizedBox(height: 10.0),
          Icon(
            weather.icon,
            size: 24.0,
            color: color,
          ),
          const SizedBox(height: 10.0),
          Text(
            '${weather.temp}°',
            style: AppTextStyles.headline4.bold.withColor(color),
          ),
        ],
      ),
    );
  }
}
