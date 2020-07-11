import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_button.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/itinerary_card.dart';

class CreatedItineraryCard extends StatelessWidget {
  const CreatedItineraryCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationBloc, DestinationState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildButton(context, state.destination.createdItinerary),
            const SizedBox(height: 8.0),
            if (state.destination.createdItinerary != null)
              ItineraryCard(
                itinerary: state.destination.createdItinerary,
                deletable: true,
              ),
          ],
        );
      },
    );
  }

  Widget _buildButton(BuildContext context, Itinerary createdItinerary) {
    return CustomButton(
      outlineOnly: true,
      color: AppColors.dark,
      iconData: CommunityMaterialIcons.map_search_outline,
      label: createdItinerary == null ? 'Create an itinerary' : 'Edit this itinerary',
      onTap: () => context.repository<DestinationNavService>().pushNamed(
            Routes.kItineraryFormPageRoute,
            arguments: context.bloc<DestinationBloc>().destination.createdItinerary,
          ),
    );
  }
}
