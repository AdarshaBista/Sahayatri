import 'package:flutter/material.dart';

import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/buttons/directions_button.dart';

import 'package:sahayatri/locator.dart';

class RouteActions extends StatelessWidget {
  const RouteActions({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Expanded(
              child: _buildViewRouteButton(context),
            ),
            const SizedBox(width: 12.0),
            const Expanded(
              child: DirectionsButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildViewRouteButton(BuildContext context) {
    return CustomButton(
      outline: true,
      label: 'View Route',
      icon: AppIcons.route,
      color: context.c.onSurface,
      onTap: () => locator<DestinationNavService>().pushNamed(Routes.routePageRoute),
    );
  }
}
