import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:sahayatri/ui/shared/widgets/buttons/custom_button.dart';

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
          child: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomButton(
                  label: 'Host',
                  iconData: Icons.circle,
                  onTap: () {},
                ),
                CustomButton(
                  label: 'Join',
                  outlineOnly: true,
                  color: AppColors.dark,
                  iconData: Icons.search_rounded,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
