import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/core/models/lodge.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class FacilitiesList extends StatelessWidget {
  const FacilitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Facilities',
            style: context.t.headlineSmall?.bold,
          ),
          const SizedBox(height: 8.0),
          _buildFacilities(context),
        ],
      ),
    );
  }

  Widget _buildFacilities(BuildContext context) {
    final facility = context.watch<Lodge>().facility;

    if (facility.isEmpty) {
      return Text(
        'N/A',
        style: AppTextStyles.headline6,
      );
    }

    return Wrap(
      spacing: 8.0,
      children: [
        if (facility.wifi) _buildIcon(context, AppIcons.wifi),
        if (facility.toilet) _buildIcon(context, AppIcons.toilet),
        if (facility.shower) _buildIcon(context, AppIcons.shower),
      ],
    );
  }

  Widget _buildIcon(BuildContext context, IconData icon) {
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
            color: context.c.primaryContainer,
          ),
        ),
      ),
    );
  }
}
