import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/extensions/index.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/pages/weather_page/weather_page.dart';

import 'package:community_material_icon/community_material_icon.dart';
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
      icon: Icons.map_outlined,
      onTap: () => PlaceMapDialog(place: place).openDialog(context),
    );
  }

  Widget _buildWeatherButton(BuildContext context, Place place) {
    return CustomButton(
      label: 'Weather',
      outline: true,
      color: context.c.onBackground,
      icon: CommunityMaterialIcons.weather_fog,
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
