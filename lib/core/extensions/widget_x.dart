import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

extension WidgetX on Widget {
  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: true,
      useRootNavigator: false,
      barrierDismissible: true,
      barrierColor: AppColors.barrier,
      builder: (_) => this,
    );
  }

  void openModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: false,
      isScrollControlled: true,
      barrierColor: AppColors.barrier,
      backgroundColor: AppColors.light,
      builder: (_) => this,
    );
  }

  PersistentBottomSheetController openBottomSheet(BuildContext context) {
    return showBottomSheet(
      context: context,
      elevation: 12.0,
      clipBehavior: Clip.antiAlias,
      backgroundColor: AppColors.light,
      builder: (_) => this,
    );
  }
}
