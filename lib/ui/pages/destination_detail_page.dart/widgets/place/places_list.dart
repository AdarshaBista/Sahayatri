import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/places_cubit/places_cubit.dart';

import 'package:sahayatri/ui/widgets/common/header.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/error_indicator.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/place/place_card.dart';

class PlacesList extends StatelessWidget {
  const PlacesList();

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
        const SizedBox(height: 12.0),
        BlocBuilder<PlacesCubit, PlacesState>(
          builder: (context, state) {
            if (state is PlacesError) {
              return ErrorIndicator(
                message: state.message,
                onRetry: () => context.read<PlacesCubit>().fetchPlaces(),
              );
            } else if (state is PlacesLoaded) {
              return _buildList(state.places);
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
        const SizedBox(height: 80.0),
      ],
    );
  }

  Widget _buildList(List<Place> places) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      itemExtent: 120.0,
      itemCount: places.length,
      itemBuilder: (context, index) {
        return SlideAnimator(
          duration: (index + 1) * 150,
          begin: const Offset(0.0, 1.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: PlaceCard(place: places[index]),
          ),
        );
      },
    );
  }
}
