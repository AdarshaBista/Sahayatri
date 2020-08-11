import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';
import 'package:sahayatri/ui/shared/widgets/unauthenticated_view.dart';

class UnauthenticatedDialog extends StatelessWidget {
  const UnauthenticatedDialog();

  @override
  Widget build(BuildContext context) {
    return const ScaleAnimator(
      duration: 200,
      child: AlertDialog(
        elevation: 12.0,
        clipBehavior: Clip.antiAlias,
        backgroundColor: AppColors.light,
        title: UnauthenticatedView(),
      ),
    );
  }
}
