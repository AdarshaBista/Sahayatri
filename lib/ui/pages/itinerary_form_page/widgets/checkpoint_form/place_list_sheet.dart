import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/places_cubit/places_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';

class PlaceListSheet extends StatelessWidget {
  final void Function(Place) onSelect;

  const PlaceListSheet({
    @required this.onSelect,
  }) : assert(onSelect != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Select a place',
              style: AppTextStyles.medium.bold,
            ),
            const Divider(height: 16.0),
            BlocBuilder<PlacesCubit, PlacesState>(
              builder: (context, state) {
                if (state is PlacesError) {
                  return ErrorIndicator(
                    message: state.message,
                    onRetry: context.bloc<PlacesCubit>().fetchPlaces,
                  );
                } else if (state is PlacesLoaded) {
                  return _buildList(state.places);
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
        ),
      ),
    );
  }

  Widget _buildList(List<Place> places) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: places.length,
        itemBuilder: (context, index) {
          return _buildPlaceTile(context, places[index]);
        },
      ),
    );
  }

  ListTile _buildPlaceTile(BuildContext context, Place place) {
    return ListTile(
      onTap: () {
        onSelect(place);
        Navigator.of(context).pop();
      },
      title: Text(place.name, style: AppTextStyles.medium),
      leading: CircleAvatar(backgroundImage: NetworkImage(place.imageUrls[0])),
      trailing: GestureDetector(
        onTap: () => context.repository<DestinationNavService>().pushNamed(
              Routes.kPlacePageRoute,
              arguments: place,
            ),
        child: Text(
          'View',
          style: AppTextStyles.small.primary,
        ),
      ),
    );
  }
}
