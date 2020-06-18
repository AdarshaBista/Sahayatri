import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/widgets/custom_button.dart';
import 'package:sahayatri/ui/shared/widgets/directions_button.dart';

class DestinationActions extends StatelessWidget {
  const DestinationActions();

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
      iconData: CommunityMaterialIcons.chart_line_variant,
      onTap: () =>
          context.repository<DestinationNavService>().pushNamed(Routes.kRoutePageRoute),
    );
  }
}
