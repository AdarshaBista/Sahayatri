import 'package:flutter/material.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:sahayatri/ui/pages/weather_page/weather_page.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/gradient_container.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/drawer_item.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/drawer_background.dart';

class DestinationDrawer extends StatelessWidget {
  const DestinationDrawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightAccent,
      body: Stack(
        children: [
          CustomPaint(
            foregroundPainter: DrawerBackground(),
            child: GradientContainer(
              gradientColors: AppColors.accentColors.take(3).toList(),
            ),
          ),
          Center(child: _buildMenuItems(context)),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    final destination = context.bloc<DestinationCubit>().destination;

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 32.0),
      children: [
        DrawerItem(
          icon: CommunityMaterialIcons.chart_line_variant,
          label: 'View Route',
          onTap: () => context
              .repository<DestinationNavService>()
              .pushNamed(Routes.kRoutePageRoute),
        ),
        DrawerItem(
          icon: CommunityMaterialIcons.weather_fog,
          label: 'Weather',
          onTap: () => context.repository<DestinationNavService>().pushNamed(
                Routes.kWeatherPageRoute,
                arguments: WeatherPageArgs(
                  name: destination.name,
                  coord: destination.startingPlace.coord,
                ),
              ),
        ),
        DrawerItem(
          icon: CommunityMaterialIcons.television_guide,
          label: 'Guide Book',
          onTap: () {},
        ),
        DrawerItem(
          icon: Icons.healing_outlined,
          label: 'Safety',
          onTap: () {},
        ),
      ],
    );
  }
}
