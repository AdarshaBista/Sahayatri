import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/cubits/places_cubit/places_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/sheet_header.dart';
import 'package:sahayatri/ui/widgets/image/image_card.dart';
import 'package:sahayatri/ui/widgets/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/error_indicator.dart';

import 'package:sahayatri/locator.dart';

class PlaceListSheet extends StatelessWidget {
  final void Function(Place) onSelect;

  const PlaceListSheet({
    super.key,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SheetHeader(title: 'Select a place'),
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
      title: Text(place.name, style: context.t.headline5),
      leading: SizedBox(
        height: 50.0,
        width: 50.0,
        child: ImageCard(
          showLoading: false,
          imageUrl: place.imageUrls[0],
          backgroundColor: context.c.surface,
        ),
      ),
      trailing: GestureDetector(
        onTap: () => locator<DestinationNavService>().pushNamed(
          Routes.placePageRoute,
          arguments: place,
        ),
        child: Text(
          'VIEW',
          style: AppTextStyles.headline5.primaryDark,
        ),
      ),
    );
  }
}
