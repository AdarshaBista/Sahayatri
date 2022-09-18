import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/cubits/itinerary_cubit/itinerary_cubit.dart';
import 'package:sahayatri/cubits/user_itinerary_cubit/user_itinerary_cubit.dart';

import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/itinerary_card.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/user_itinerary_card.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/header.dart';
import 'package:sahayatri/ui/widgets/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/error_indicator.dart';

class ItinerariesList extends StatelessWidget {
  const ItinerariesList({super.key});

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
        _buildUserItinerary(context),
        const SizedBox(height: 20.0),
        _buildSuggestedItineraries(context),
        const SizedBox(height: 80.0),
      ],
    );
  }

  Widget _buildUserItinerary(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocBuilder<UserItineraryCubit, UserItineraryState>(
          builder: (context, state) {
            final title = state is UserItineraryLoaded
                ? 'My Itinerary'
                : 'Create my itinerary';
            return Text(
              title,
              style: context.t.headline5?.bold,
            );
          },
        ),
        const SizedBox(height: 12.0),
        const UserItineraryCard(),
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
          style: context.t.headline5?.bold,
        ),
        const SizedBox(height: 12.0),
        BlocBuilder<ItineraryCubit, ItineraryState>(
          builder: (context, state) {
            if (state is ItineraryError) {
              return ErrorIndicator(
                message: state.message,
                onRetry: () =>
                    context.read<ItineraryCubit>().fetchItineraries(),
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
                onRetry: () =>
                    context.read<ItineraryCubit>().fetchItineraries(),
              );
            } else {
              return const BusyIndicator();
            }
          },
        ),
      ],
    );
  }
}
