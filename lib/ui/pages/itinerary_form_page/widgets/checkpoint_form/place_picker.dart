import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/checkpoint_form/place_list_sheet.dart';

class PlacePicker extends StatefulWidget {
  final Place initialPlace;
  final List<Place> places;
  final Function(Place) onSelect;

  const PlacePicker({
    @required this.places,
    @required this.onSelect,
    @required this.initialPlace,
  })  : assert(places != null),
        assert(onSelect != null);

  @override
  _PlacePickerState createState() => _PlacePickerState();
}

class _PlacePickerState extends State<PlacePicker> {
  Place selectedPlace;

  @override
  void initState() {
    super.initState();
    selectedPlace = widget.initialPlace;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Place',
          style: AppTextStyles.medium,
        ),
        const SizedBox(height: 8.0),
        CustomCard(
          elevation: 0.0,
          borderRadius: 8.0,
          child: ListTile(
            dense: true,
            title: Text(
              selectedPlace?.name ?? 'No place selected',
              style: AppTextStyles.small,
            ),
            leading: Icon(
              Icons.place,
              size: 22.0,
            ),
            trailing:
                selectedPlace == null ? Offstage() : _buildViewButton(context),
            onTap: () {
              FocusScope.of(context).unfocus();
              _selectPlace(context);
            },
          ),
        ),
      ],
    );
  }

  GestureDetector _buildViewButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        Routes.kPlacePageRoute,
        arguments: selectedPlace,
      ),
      child: Text(
        'View',
        style: AppTextStyles.small.primary,
      ),
    );
  }

  void _selectPlace(BuildContext context) {
    return PlaceListSheet(
      context: context,
      places: widget.places,
      onSelect: (place) {
        setState(() {
          selectedPlace = place;
          widget.onSelect(selectedPlace);
        });
      },
    ).show();
  }
}
