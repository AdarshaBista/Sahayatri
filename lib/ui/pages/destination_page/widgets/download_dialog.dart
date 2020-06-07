import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';
import 'package:sahayatri/ui/shared/indicators/downloading_indicator.dart';

class DownloadDialog extends StatelessWidget {
  final String title;

  const DownloadDialog({
    @required this.title,
  }) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      duration: 200,
      child: AlertDialog(
        elevation: 12.0,
        clipBehavior: Clip.antiAlias,
        backgroundColor: AppColors.background,
        title: DownloadingIndicator(title: title),
      ),
    );
  }
}
