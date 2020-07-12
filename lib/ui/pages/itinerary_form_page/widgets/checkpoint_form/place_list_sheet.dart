import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';

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
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: context.bloc<DestinationBloc>().destination.places.length,
                itemBuilder: (context, index) {
                  return _buildPlaceTile(
                    context,
                    context.bloc<DestinationBloc>().destination.places[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildPlaceTile(BuildContext context, Place place) {
    return ListTile(
      onTap: () {
        onSelect(place);
        context.repository<DestinationNavService>().pop();
      },
      title: Text(place.name, style: AppTextStyles.medium),
      leading: CircleAvatar(backgroundImage: AssetImage(place.imageUrls[0])),
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
