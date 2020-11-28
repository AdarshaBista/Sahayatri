import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/itinerary_card.dart';

class CreatedItineraryCard extends StatelessWidget {
  const CreatedItineraryCard();

  @override
  Widget build(BuildContext context) {
    final destination = context.watch<Destination>();

    return destination.createdItinerary == null
        ? _buildButton(context)
        : Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ItineraryCard(
              deletable: true,
              itinerary: destination.createdItinerary,
            ),
          );
  }

  Widget _buildButton(BuildContext context) {
    return CustomButton(
      color: context.c.primaryVariant,
      backgroundColor: AppColors.primaryLight,
      icon: CommunityMaterialIcons.pencil_circle_outline,
      label: 'Create an itinerary',
      onTap: () =>
          context.read<DestinationNavService>().pushNamed(Routes.itineraryFormPageRoute),
    );
  }
}
