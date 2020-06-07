import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/widgets/header.dart';
import 'package:sahayatri/ui/shared/widgets/custom_button.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/itinerary_card.dart';

class ItinerariesList extends StatelessWidget {
  const ItinerariesList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      children: [
        Header(
          title: 'Itinerary',
          leftPadding: 0.0,
        ),
        const SizedBox(height: 20.0),
        _buildSuggestedItineraries(context),
        _buildCreateditinerary(context),
        const SizedBox(height: 32.0),
      ],
    );
  }

  Widget _buildSuggestedItineraries(BuildContext context) {
    final suggestedItineraries =
        context.bloc<DestinationBloc>().destination.suggestedItineraries;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Our Suggested Itineraries',
          style: AppTextStyles.medium,
        ),
        const Divider(height: 16.0),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: suggestedItineraries.length,
          itemBuilder: (context, index) {
            return ItineraryCard(itinerary: suggestedItineraries[index]);
          },
        ),
      ],
    );
  }

  Widget _buildCreateditinerary(BuildContext context) {
    return BlocBuilder<DestinationBloc, DestinationState>(
      condition: (previous, current) {
        return previous.destination.createdItinerary !=
            current.destination.createdItinerary;
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            Text(
              'Or Create Your Own',
              style: AppTextStyles.medium,
            ),
            const Divider(height: 16.0),
            CustomButton(
              outlineOnly: true,
              color: AppColors.dark,
              iconData: CommunityMaterialIcons.map_search_outline,
              label: state.destination.createdItinerary == null
                  ? 'Create an itinerary'
                  : 'Edit this itinerary',
              onTap: () {
                context.repository<DestinationNavService>().pushNamed(
                      Routes.kItineraryFormPageRoute,
                      arguments: context
                          .bloc<DestinationBloc>()
                          .destination
                          .createdItinerary,
                    );
              },
            ),
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
}
