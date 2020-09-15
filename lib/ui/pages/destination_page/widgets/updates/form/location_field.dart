import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/select_location_dialog.dart';

class LocationField extends StatefulWidget {
  const LocationField();

  @override
  _LocationFieldState createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  final List<Coord> coords = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Location',
          style: AppTextStyles.small.bold,
        ),
        const SizedBox(height: 4.0),
        Text(
          '${coords.length} locations selected',
          style: AppTextStyles.extraSmall.primaryDark,
        ),
        CustomButton(
            label: 'View / Select Locations',
            color: AppColors.primaryDark,
            backgroundColor: AppColors.primaryLight,
            iconData: CommunityMaterialIcons.map_marker_plus_outline,
            onTap: () => SelectLocationDialog(
                  coords: coords,
                  onAdd: (coord) => setState(() => coords.add(coord)),
                  onRemove: (coord) => setState(() => coords.remove(coord)),
                ).openDialog(context)),
      ],
    );
  }
}
