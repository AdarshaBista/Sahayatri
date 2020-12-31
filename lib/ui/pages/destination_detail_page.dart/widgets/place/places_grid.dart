import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/places_cubit/places_cubit.dart';

import 'package:sahayatri/ui/widgets/common/header.dart';
import 'package:sahayatri/ui/widgets/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/error_indicator.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/place/place_card.dart';

class PlacesGrid extends StatelessWidget {
  const PlacesGrid();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(height: 12.0),
        const Header(
          title: 'Places',
          padding: 20.0,
          slideDirection: SlideDirection.right,
        ),
        BlocBuilder<PlacesCubit, PlacesState>(
          builder: (context, state) {
            if (state is PlacesError) {
              return ErrorIndicator(
                message: state.message,
                onRetry: () => context.read<PlacesCubit>().fetchPlaces(),
              );
            } else if (state is PlacesLoaded) {
              return _buildGrid(state.places);
            } else if (state is PlacesEmpty) {
              return EmptyIndicator(
                message: 'No places found.',
                onRetry: () => context.read<PlacesCubit>().fetchPlaces(),
              );
            } else {
              return const BusyIndicator();
            }
          },
        ),
        const SizedBox(height: 32.0),
      ],
    );
  }

  Widget _buildGrid(List<Place> places) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        top: 12.0,
        left: 20.0,
        right: 20.0,
        bottom: 80.0,
      ),
      itemCount: places.length,
      itemBuilder: (context, index) {
        return PlaceCard(place: places[index]);
      },
    );
  }
}
