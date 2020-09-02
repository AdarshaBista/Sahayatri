import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/places_cubit/places_cubit.dart';

import 'package:sahayatri/ui/shared/widgets/header.dart';
import 'package:sahayatri/ui/shared/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/place/place_card.dart';

class PlacesGrid extends StatelessWidget {
  const PlacesGrid();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: [
        const SizedBox(height: 16.0),
        const Header(title: 'Places'),
        BlocBuilder<PlacesCubit, PlacesState>(
          builder: (context, state) {
            if (state is PlacesError) {
              return ErrorIndicator(
                message: state.message,
                onRetry: context.bloc<PlacesCubit>().fetchPlaces,
              );
            } else if (state is PlacesLoaded) {
              return _buildGrid(state.places);
            } else if (state is PlacesEmpty) {
              return EmptyIndicator(
                message: 'No places found.',
                onRetry: context.bloc<PlacesCubit>().fetchPlaces,
              );
            } else {
              return const BusyIndicator();
            }
          },
        ),
      ],
    );
  }

  Widget _buildGrid(List<Place> places) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        top: 20.0,
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
