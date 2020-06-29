import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:community_material_icon/community_material_icon.dart';

class DistanceStats extends StatelessWidget {
  final double walked;
  final double remaining;

  const DistanceStats({
    @required this.walked,
    @required this.remaining,
  })  : assert(walked != null),
        assert(remaining != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: CustomCard(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStat(
              walked,
              'metres walked',
              CommunityMaterialIcons.shoe_print,
              Colors.green,
            ),
            const Divider(height: 16.0),
            _buildStat(
              remaining,
              'metres remaining',
              CommunityMaterialIcons.map_marker_distance,
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(double stat, String label, IconData icon, Color color) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Icon(
          icon,
          color: color,
          size: 22.0,
        ),
        const SizedBox(width: 8.0),
        Text(
          stat.toStringAsFixed(0),
          style: AppTextStyles.large.bold,
        ),
        const SizedBox(width: 8.0),
        Text(
          label,
          style: AppTextStyles.small,
        ),
      ],
    );
  }
}
