import 'package:flutter/material.dart';

import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/extensions/dialog_extension.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/checkpoint_form/custom_form_tile.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/checkpoint_form/place_list_sheet.dart';
import 'package:sahayatri/ui/styles/styles.dart';

import 'package:sahayatri/locator.dart';

class PlacePicker extends StatefulWidget {
  final Place? initialPlace;
  final void Function(Place) onSelect;

  const PlacePicker({
    super.key,
    required this.onSelect,
    required this.initialPlace,
  });

  @override
  State<PlacePicker> createState() => _PlacePickerState();
}

class _PlacePickerState extends State<PlacePicker> {
  late Place? selectedPlace;

  @override
  void initState() {
    super.initState();
    selectedPlace = widget.initialPlace;
  }

  @override
  Widget build(BuildContext context) {
    return CustomFormTile(
      title: 'Place',
      icon: AppIcons.place,
      hintText: selectedPlace?.name ?? 'No place selected',
      trailing: selectedPlace == null ? const SizedBox() : _buildViewButton(),
      onTap: () {
        FocusScope.of(context).unfocus();
        _selectPlace(context);
      },
    );
  }

  GestureDetector _buildViewButton() {
    return GestureDetector(
      onTap: () => locator<DestinationNavService>().pushNamed(
        Routes.placePageRoute,
        arguments: selectedPlace,
      ),
      child: Text(
        'View',
        style: AppTextStyles.headline5.primary,
      ),
    );
  }

  void _selectPlace(BuildContext context) {
    PlaceListSheet(
      onSelect: (place) {
        setState(() {
          selectedPlace = place;
          widget.onSelect(place);
        });
      },
    ).openModalBottomSheet(context);
  }
}
