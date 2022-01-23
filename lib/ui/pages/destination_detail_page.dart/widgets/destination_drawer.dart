import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/pages/weather_page/weather_page.dart';

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
          const CustomPaint(
            foregroundPainter: _DrawerBackground(),
            child: GradientContainer(
              gradientColors: AppColors.drawerGradient,
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
          icon: AppIcons.route,
          label: 'Route',
          onTap: () {
            locator<DestinationNavService>().pushNamed(Routes.routePageRoute);
          },
        ),
        DrawerItem(
          icon: AppIcons.weather,
          label: 'Weather',
          onTap: () {
            final destination = context.read<Destination>();
            locator<DestinationNavService>().pushNamed(
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

    canvas.drawCircle(Offset(size.width, 0.0), 220.0, paint);
    canvas.drawCircle(Offset(size.width, 0.0), 130.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
