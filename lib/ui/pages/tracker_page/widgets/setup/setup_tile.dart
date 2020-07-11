import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:timeline_tile/timeline_tile.dart';

class SetupTile extends StatelessWidget {
  final bool isLast;
  final bool isFirst;
  final Widget child;
  final String title;
  final IconData icon;

  const SetupTile({
    @required this.icon,
    @required this.child,
    @required this.title,
    this.isLast = false,
    this.isFirst = false,
  })  : assert(icon != null),
        assert(child != null),
        assert(title != null),
        assert(isLast != null),
        assert(isFirst != null);

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isLast: isLast,
      isFirst: isFirst,
      indicatorStyle: IndicatorStyle(
        width: 36.0,
        height: 36.0,
        indicatorY: 0.1,
        padding: const EdgeInsets.only(right: 16.0, top: 4.0, bottom: 4.0),
        indicator: CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Icon(
            icon,
            size: 16.0,
            color: AppColors.dark,
          ),
        ),
      ),
      topLineStyle: const LineStyle(
        width: 1.0,
        color: AppColors.disabled,
      ),
      bottomLineStyle: const LineStyle(
        width: 1.0,
        color: AppColors.disabled,
      ),
      rightChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.medium,
          ),
          const SizedBox(height: 12.0),
          child,
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
