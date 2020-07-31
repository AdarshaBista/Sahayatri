import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:sahayatri/ui/shared/widgets/nearby/nearby_button.dart';

class NearbyForm extends StatelessWidget {
  const NearbyForm();

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      curve: Curves.decelerate,
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 200),
      child: FadeAnimator(
        child: SlideAnimator(
          begin: const Offset(0.0, 1.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Nearby',
                style: AppTextStyles.small.bold,
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  NearbyButton(
                    label: 'Host',
                    color: Colors.lightBlue,
                    icon: CommunityMaterialIcons.circle_double,
                    onTap: () {},
                  ),
                  const SizedBox(width: 12.0),
                  NearbyButton(
                    label: 'Join',
                    color: Colors.green,
                    icon: CommunityMaterialIcons.account_search_outline,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
