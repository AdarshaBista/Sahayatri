import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_button.dart';
import 'package:sahayatri/ui/shared/widgets/directions_button.dart';
import 'package:sahayatri/ui/shared/indicators/location_error_indicator.dart';

class IncorrectLocationInfo extends StatelessWidget {
  const IncorrectLocationInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LocationErrorIndicator(
              message:
                  'You do not seem to be at the trailhead. Tracking is only possible when you are near the trailhead. Would you like to go there.',
            ),
            Row(
              children: [
                const Expanded(
                  child: DirectionsButton(label: 'Sure, why not'),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: CustomButton(
                    label: 'No thanks',
                    outlineOnly: true,
                    iconData: Icons.close,
                    color: AppColors.dark,
                    onTap: () => context.repository<DestinationNavService>().pop(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
