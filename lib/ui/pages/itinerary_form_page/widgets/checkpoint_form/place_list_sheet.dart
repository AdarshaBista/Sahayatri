import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class PlaceListSheet {
  final BuildContext context;
  final List<Place> places;
  final Function(Place) onSelect;

  const PlaceListSheet({
    @required this.context,
    @required this.places,
    @required this.onSelect,
  })  : assert(context != null),
        assert(places != null),
        assert(onSelect != null);

  Widget _build() {
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
                physics: BouncingScrollPhysics(),
                itemCount: places.length,
                itemBuilder: (context, index) {
                  return _buildPlaceTile(places[index], context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildPlaceTile(Place place, BuildContext context) {
    return ListTile(
      onTap: () {
        onSelect(place);
        Navigator.of(context).pop();
      },
      title: Text(place.name, style: AppTextStyles.medium),
      leading: CircleAvatar(backgroundImage: AssetImage(place.imageUrls[0])),
      trailing: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
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

  void show() {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: false,
      isScrollControlled: true,
      barrierColor: AppColors.barrier,
      backgroundColor: AppColors.background,
      builder: (_) => _build(),
    );
  }
}
