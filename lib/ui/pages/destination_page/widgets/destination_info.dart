import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/directions_bloc/directions_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/widgets/custom_button.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';

class DestinationInfo extends StatelessWidget {
  const DestinationInfo();

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.bloc<DestinationBloc>().destination.description,
              textAlign: TextAlign.left,
              style: AppTextStyles.small.serif,
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(
                  child: _buildViewRouteButton(context),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: _buildGetDirectionsButton(context),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewRouteButton(BuildContext context) {
    return Hero(
      tag: context.bloc<DestinationBloc>().destination.routePoints,
      child: CustomButton(
        label: 'View Route',
        iconData: CommunityMaterialIcons.chart_line_variant,
        onTap: () => context.repository<DestinationNavService>().pushNamed(
              Routes.kRoutePageRoute,
              arguments: context.bloc<DestinationBloc>().destination.places,
            ),
      ),
    );
  }

  Widget _buildGetDirectionsButton(BuildContext context) {
    return BlocListener<DirectionsBloc, DirectionsState>(
      listener: (context, state) {
        if (state is DirectionsError)
          _showErrorSnackBar(context, state.message);
        if (state is DirectionsLoading) _showLoadingSnackBar(context);
      },
      child: CustomButton(
        label: 'Get Directions',
        outlineOnly: true,
        color: AppColors.dark,
        iconData: CommunityMaterialIcons.directions,
        onTap: () => context.bloc<DirectionsBloc>().add(
              DirectionsStarted(
                trailHead:
                    context.bloc<DestinationBloc>().destination.startingPlace,
              ),
            ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: AppTextStyles.small.light,
          ),
        ),
      );
  }

  void _showLoadingSnackBar(BuildContext context) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Loading Directions. Please wait...',
            style: AppTextStyles.small.light,
          ),
        ),
      );
  }
}
