import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/buttons/column_button.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class FacilitiesList extends StatelessWidget {
  const FacilitiesList();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Facilities',
            style: AppTextStyles.medium.bold,
          ),
          const SizedBox(height: 12.0),
          _buildFacilities(context),
        ],
      ),
    );
  }

  Widget _buildFacilities(BuildContext context) {
    final facility = context.watch<Lodge>().facility;

    return Wrap(
      spacing: 8.0,
      children: [
        if (facility.wifi)
          _buildIcon(
            'WiFi',
            Colors.green,
            CommunityMaterialIcons.wifi,
          ),
        if (facility.toilet)
          _buildIcon(
            'Toilet',
            Colors.red,
            CommunityMaterialIcons.toilet,
          ),
        if (facility.shower)
          _buildIcon(
            'Shower',
            Colors.blue,
            CommunityMaterialIcons.shower_head,
          ),
      ],
    );
  }

  Widget _buildIcon(String label, Color color, IconData icon) {
    return ScaleAnimator(
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: ColumnButton(
            label: label,
            icon: icon,
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
