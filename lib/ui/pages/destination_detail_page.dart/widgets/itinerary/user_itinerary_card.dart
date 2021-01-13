import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_itinerary_cubit/user_itinerary_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/itinerary_card.dart';

class UserItineraryCard extends StatelessWidget {
  const UserItineraryCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserItineraryCubit, UserItineraryState>(
      builder: (context, state) {
        if (state is UserItineraryLoaded) {
          return _buildItineraryCard(state.userItinerary);
        } else if (state is UserItineraryLoading) {
          return const BusyIndicator();
        }
        return _buildButton(context);
      },
    );
  }

  Widget _buildItineraryCard(Itinerary itinerary) {
    return ItineraryCard(
      deletable: true,
      itinerary: itinerary,
    );
  }

  Widget _buildButton(BuildContext context) {
    return CustomButton(
      icon: AppIcons.create,
      color: context.c.primaryVariant,
      backgroundColor: AppColors.primaryLight,
      label: 'Create',
      onTap: () => locator<DestinationNavService>().pushNamed(
        Routes.itineraryFormPageRoute,
      ),
    );
  }
}
