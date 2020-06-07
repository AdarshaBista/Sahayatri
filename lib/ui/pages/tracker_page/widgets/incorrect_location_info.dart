import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/directions_bloc/directions_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_button.dart';
import 'package:sahayatri/ui/shared/indicators/location_error_indicator.dart';

class IncorrectLocationInfo extends StatelessWidget {
  const IncorrectLocationInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const LocationErrorIndicator(
            message: '''
                    You do not seem to be at the trailhead. 
                    Tracking is only possible when you are near the trailhead. 
                    Would you like to go there.''',
          ),
          CustomButton(
            label: 'Sure, why not',
            iconData: Icons.check,
            backgroundColor: Colors.teal,
            onTap: () {
              context.bloc<DirectionsBloc>().add(DirectionsStarted(
                    trailHead: context
                        .bloc<DestinationBloc>()
                        .destination
                        .startingPlace,
                  ));
            },
          ),
          CustomButton(
            label: 'No thanks',
            outlineOnly: true,
            iconData: Icons.close,
            color: AppColors.dark,
            onTap: () => context.repository<DestinationNavService>().pop(),
          ),
        ],
      ),
    );
  }
}
