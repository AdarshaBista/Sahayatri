import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/models/lodge_facility.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';
import 'package:community_material_icon/community_material_icon.dart';

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
            style: AppTextStyles.small.bold,
          ),
          const SizedBox(height: 10.0),
          _buildFacilities(context),
        ],
      ),
    );
  }

  Widget _buildFacilities(BuildContext context) {
    final facility = context.select<Lodge, LodgeFacility>((l) => l.facility);

    if (facility.isEmpty) {
      return Text(
        'N/A',
        style: AppTextStyles.extraSmall,
      );
    }

    return Wrap(
      spacing: 8.0,
      children: [
        if (facility.wifi) _buildIcon(CommunityMaterialIcons.wifi),
        if (facility.toilet) _buildIcon(CommunityMaterialIcons.toilet),
        if (facility.shower) _buildIcon(CommunityMaterialIcons.shower_head),
      ],
    );
  }

  Widget _buildIcon(IconData icon) {
    return ScaleAnimator(
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Icon(
            icon,
            color: AppColors.primaryDark,
          ),
        ),
      ),
    );
  }
}
