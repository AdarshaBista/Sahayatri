import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';
import 'package:sahayatri/ui/shared/indicators/loading_indicator.dart';

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingIndicator(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Text(
                'Downloading $title',
                style: AppTextStyles.medium,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
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
