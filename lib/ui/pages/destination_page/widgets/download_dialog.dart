import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';
import 'package:sahayatri/ui/shared/indicators/downloading_indicator.dart';

class DownloadDialog {
  final BuildContext context;
  final String title;

  const DownloadDialog({
    @required this.context,
    @required this.title,
  })  : assert(context != null),
        assert(title != null);

  Widget _build() {
    return ScaleAnimator(
      child: CustomCard(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1,
          vertical: MediaQuery.of(context).size.height * 0.2,
        ),
        color: AppColors.background,
        child: DownloadingIndicator(title: title),
      ),
    );
  }

  void show() {
    showDialog(
      context: context,
      useSafeArea: true,
      useRootNavigator: false,
      barrierDismissible: true,
      barrierColor: AppColors.barrier,
      builder: (_) => _build(),
    );
  }
}
