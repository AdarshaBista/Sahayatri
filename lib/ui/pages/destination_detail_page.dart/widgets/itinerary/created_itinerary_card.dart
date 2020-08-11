import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/itinerary_card.dart';

class CreatedItineraryCard extends StatelessWidget {
  const CreatedItineraryCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationCubit, Destination>(
      builder: (context, destination) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildButton(context, destination.createdItinerary),
            if (destination.createdItinerary != null)
              ItineraryCard(
                itinerary: destination.createdItinerary,
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
      iconData: CommunityMaterialIcons.pencil_circle_outline,
      label: createdItinerary == null ? 'Create an itinerary' : 'Edit itinerary',
      onTap: () => context.repository<DestinationNavService>().pushNamed(
            Routes.kItineraryFormPageRoute,
            arguments: context.bloc<DestinationCubit>().destination.createdItinerary,
          ),
    );
  }
}
