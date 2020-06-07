import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

extension WidgetX on Widget {
  void openDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      useSafeArea: true,
      useRootNavigator: false,
      barrierDismissible: true,
      barrierColor: AppColors.barrier,
      builder: (_) => this,
    );
  }

  void openModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: false,
      isScrollControlled: true,
      barrierColor: AppColors.barrier,
      backgroundColor: AppColors.background,
      builder: (_) => this,
    );
  }
}