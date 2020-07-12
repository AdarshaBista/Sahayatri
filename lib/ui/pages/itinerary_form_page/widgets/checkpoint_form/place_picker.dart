import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/utils/form_validators.dart';
import 'package:sahayatri/core/extensions/widget_x.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/widgets/custom_form_field.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/checkpoint_form/place_list_sheet.dart';

class PlacePicker extends StatefulWidget {
  final Place initialPlace;
  final Function(Place) onSelect;

  const PlacePicker({
    @required this.onSelect,
    @required this.initialPlace,
  }) : assert(onSelect != null);

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
    return CustomFormField<Place>(
      initialValue: widget.initialPlace,
      validator: FormValidators.nonNull('Please select a place.'),
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Place',
              style: AppTextStyles.medium,
            ),
            const SizedBox(height: 8.0),
            CustomCard(
              child: ListTile(
                dense: true,
                title: Text(
                  selectedPlace?.name ?? 'No place selected',
                  style: AppTextStyles.small,
                ),
                leading: const Icon(
                  Icons.place,
                  size: 22.0,
                ),
                trailing:
                    selectedPlace == null ? const Offstage() : _buildViewButton(context),
                onTap: () {
                  FocusScope.of(context).unfocus();
                  _selectPlace(context);
                  field.didChange(selectedPlace);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  GestureDetector _buildViewButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.repository<DestinationNavService>().pushNamed(
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
    PlaceListSheet(
      onSelect: (place) {
        setState(() {
          selectedPlace = place;
          widget.onSelect(selectedPlace);
        });
      },
    ).openModalBottomSheet(context);
  }
}
