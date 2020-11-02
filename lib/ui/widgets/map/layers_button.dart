import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

class LayersButton extends StatelessWidget {
  const LayersButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SlideAnimator(
        begin: const Offset(1.0, 0.0),
        child: GestureDetector(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.dark,
              shape: BoxShape.circle,
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                CommunityMaterialIcons.layers_outline,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
