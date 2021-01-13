import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/extensions/dialog_extension.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/pages/weather_page/weather_page.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/pages/place_page/widgets/place_map_dialog.dart';

class PlaceActions extends StatelessWidget {
  const PlaceActions();

  @override
  Widget build(BuildContext context) {
    final place = context.watch<Place>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(child: _buildViewMapButton(context, place)),
          const SizedBox(width: 8.0),
          Expanded(child: _buildWeatherButton(context, place)),
        ],
      ),
    );
  }

  Widget _buildViewMapButton(BuildContext context, Place place) {
    return CustomButton(
      label: 'View Map',
      icon: AppIcons.map,
      onTap: () => PlaceMapDialog(place: place).openDialog(context),
    );
  }

  Widget _buildWeatherButton(BuildContext context, Place place) {
    return CustomButton(
      label: 'Weather',
      outline: true,
      icon: AppIcons.weather,
      color: context.c.onBackground,
      onTap: () => locator<DestinationNavService>().pushNamed(
        Routes.weatherPageRoute,
        arguments: WeatherPageArgs(
          name: place.name,
          coord: place.coord,
        ),
      ),
    );
  }
}
