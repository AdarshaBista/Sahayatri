import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/header.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/itinerary_card.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/created_itinerary_card.dart';

class ItinerariesList extends StatelessWidget {
  const ItinerariesList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      children: [
        const Header(
          title: 'Itinerary',
          leftPadding: 0.0,
        ),
        const SizedBox(height: 20.0),
        _buildSuggestedItineraries(context),
        _buildCreatedItinerary(),
        const SizedBox(height: 72.0),
      ],
    );
  }

  Widget _buildSuggestedItineraries(BuildContext context) {
    final suggestedItineraries =
        context.bloc<DestinationCubit>().destination.suggestedItineraries;

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

  Widget _buildCreatedItinerary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Text(
          'Create Your Own',
          style: AppTextStyles.medium,
        ),
        const Divider(height: 16.0),
        const CreatedItineraryCard(),
      ],
    );
  }
}
