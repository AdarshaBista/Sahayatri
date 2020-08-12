import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';
import 'package:sahayatri/ui/pages/place_page/widgets/lodge_card.dart';
import 'package:sahayatri/ui/pages/place_page/widgets/lodges_map_dialog.dart';

class LodgesGrid extends StatelessWidget {
  const LodgesGrid();

  @override
  Widget build(BuildContext context) {
    final place = Provider.of<Place>(context, listen: false);
    final lodges = place.lodges;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomButton(
            label: 'View on Map',
            outlineOnly: true,
            color: AppColors.dark,
            iconData: Icons.hotel_outlined,
            onTap: () => LodgesMapDialog(place: place).openDialog(context),
          ),
        ),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 10 / 13,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
          ),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          itemCount: lodges.length,
          itemBuilder: (context, index) {
            return LodgeCard(lodge: lodges[index]);
          },
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }
}
