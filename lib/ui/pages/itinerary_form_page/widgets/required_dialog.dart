import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/indicators/required_indicator.dart';

class RequiredDialog {
  final BuildContext context;

  const RequiredDialog({
    @required this.context,
  }) : assert(context != null);

  Widget _build() {
    return CustomCard(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.2,
        vertical: MediaQuery.of(context).size.height * 0.3,
      ),
      color: AppColors.background,
      child: const RequiredIndicator(),
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
