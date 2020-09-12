import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class TagList extends StatelessWidget {
  final List<String> tags;

  const TagList({
    @required this.tags,
  }) : assert(tags != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Wrap(
        spacing: 8.0,
        children: tags
            .map(
              (m) => ScaleAnimator(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(32.0),
                    border: Border.all(width: 0.5, color: AppColors.barrier),
                  ),
                  child: Text(m, style: AppTextStyles.extraSmall),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
