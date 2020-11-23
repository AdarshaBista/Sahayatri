import 'package:flutter/material.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
      label: 'View Route',
      outlineOnly: true,
      color: context.c.onSurface,
      backgroundColor: context.c.onSurface,
      iconData: CommunityMaterialIcons.chart_line_variant,
      onTap: () => context.read<DestinationNavService>().pushNamed(Routes.routePageRoute),
    );
  }
}
