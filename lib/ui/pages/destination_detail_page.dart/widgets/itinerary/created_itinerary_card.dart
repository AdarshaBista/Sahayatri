import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/itinerary_card.dart';

class CreatedItineraryCard extends StatelessWidget {
  const CreatedItineraryCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationCubit, Destination>(
      builder: (context, destination) {
        return destination.createdItinerary == null
            ? _buildButton(context, destination.createdItinerary)
            : Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ItineraryCard(
                  deletable: true,
                  itinerary: destination.createdItinerary,
                ),
              );
      },
    );
  }

  Widget _buildButton(BuildContext context, Itinerary createdItinerary) {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        color: AppColors.primaryDark,
        backgroundColor: AppColors.primaryLight,
        iconData: CommunityMaterialIcons.pencil_circle_outline,
        label: createdItinerary == null ? 'Create an itinerary' : 'Edit itinerary',
        onTap: () => context.repository<DestinationNavService>().pushNamed(
              Routes.kItineraryFormPageRoute,
              arguments: context.bloc<DestinationCubit>().destination.createdItinerary,
            ),
      ),
    );
  }
}
