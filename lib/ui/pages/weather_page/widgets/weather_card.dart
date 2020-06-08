import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/weather.dart';

class WeatherCard extends StatelessWidget {
  final bool expanded;
  final Weather weather;

  const WeatherCard({
    @required this.weather,
    @required this.expanded,
  })  : assert(weather != null),
        assert(expanded != null);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(weather.label),
      initiallyExpanded: expanded,
    );
  }
}
