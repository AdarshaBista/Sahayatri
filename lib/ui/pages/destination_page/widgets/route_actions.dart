import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/buttons/directions_button.dart';

class RouteActions extends StatelessWidget {
  const RouteActions();

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
      color: context.c.onSurface,
      icon: CommunityMaterialIcons.chart_line_variant,
      onTap: () => locator<DestinationNavService>().pushNamed(Routes.routePageRoute),
    );
  }
}
