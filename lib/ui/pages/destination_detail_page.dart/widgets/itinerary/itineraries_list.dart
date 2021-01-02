import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/itinerary_cubit/itinerary_cubit.dart';
import 'package:sahayatri/cubits/user_itinerary_cubit/user_itinerary_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/header.dart';
import 'package:sahayatri/ui/widgets/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/error_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/itinerary_card.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/user_itinerary_card.dart';

class ItinerariesList extends StatelessWidget {
  const ItinerariesList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      children: [
        const SizedBox(height: 12.0),
        const Header(
          title: 'Itinerary',
          slideDirection: SlideDirection.right,
        ),
        const SizedBox(height: 12.0),
        _buildSuggestedItineraries(context),
        const SizedBox(height: 12.0),
        _buildUserItinerary(context),
        const SizedBox(height: 80.0),
      ],
    );
  }

  Widget _buildSuggestedItineraries(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Suggested Itineraries',
          style: context.t.headline5.bold,
        ),
        const Divider(height: 16.0),
        const SizedBox(height: 8.0),
        BlocBuilder<ItineraryCubit, ItineraryState>(
          builder: (context, state) {
            if (state is ItineraryError) {
              return ErrorIndicator(
                message: state.message,
                onRetry: () => context.read<ItineraryCubit>().fetchItineraries(),
              );
            } else if (state is ItineraryLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.itineraries.length,
                itemBuilder: (context, index) {
                  return ItineraryCard(itinerary: state.itineraries[index]);
                },
              );
            } else if (state is ItineraryEmpty) {
              return EmptyIndicator(
                message: 'No itineraries found.',
                onRetry: () => context.read<ItineraryCubit>().fetchItineraries(),
              );
            } else {
              return const BusyIndicator();
            }
          },
        ),
      ],
    );
  }

  Widget _buildUserItinerary(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        BlocBuilder<UserItineraryCubit, UserItineraryState>(
          builder: (context, state) {
            if (state is UserItineraryLoaded) {
              return Text(
                'My Itinerary',
                style: context.t.headline5.bold,
              );
            }
            return Text(
              'Create Your Own',
              style: context.t.headline5.bold,
            );
          },
        ),
        const Divider(height: 16.0),
        const SizedBox(height: 8.0),
        const UserItineraryCard(),
      ],
    );
  }
}
