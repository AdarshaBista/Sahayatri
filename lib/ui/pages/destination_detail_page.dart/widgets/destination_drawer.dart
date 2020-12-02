import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/theme_cubit/theme_cubit.dart';

import 'package:sahayatri/ui/pages/weather_page/weather_page.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/gradient_container.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/drawer_item.dart';

class DestinationDrawer extends StatelessWidget {
  const DestinationDrawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightAccent,
      body: Stack(
        children: [
          CustomPaint(
            foregroundPainter: const _DrawerBackground(),
            child: GradientContainer(
              gradientColors:
                  AppColors.getDrawerGradient(context.watch<ThemeCubit>().isDark),
            ),
          ),
          Center(child: _buildMenuItems(context)),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 32.0),
      children: [
        DrawerItem(
          icon: CommunityMaterialIcons.chart_line_variant,
          label: 'Route',
          onTap: () =>
              context.read<DestinationNavService>().pushNamed(Routes.routePageRoute),
        ),
        DrawerItem(
          icon: CommunityMaterialIcons.weather_fog,
          label: 'Weather',
          onTap: () {
            final destination = context.read<Destination>();
            return context.read<DestinationNavService>().pushNamed(
                  Routes.weatherPageRoute,
                  arguments: WeatherPageArgs(
                    name: destination.name,
                    coord: destination.route.first,
                  ),
                );
          },
        ),
      ],
    );
  }
}

class _DrawerBackground extends CustomPainter {
  const _DrawerBackground();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.light.withOpacity(0.1);

    canvas.drawCircle(Offset.zero, 220.0, paint);
    canvas.drawCircle(Offset.zero, 130.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
