import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

extension WidgetX on Widget {
  void openDialog(BuildContext context, {bool barrierDismissible = true}) {
    showDialog(
      context: context,
      useSafeArea: true,
      useRootNavigator: false,
      barrierColor: AppColors.barrier,
      barrierDismissible: barrierDismissible,
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

  void openModalBottomSheet(BuildContext context, {bool isDismissible = true}) {
    showModalBottomSheet(
      context: context,
      elevation: 12.0,
      useRootNavigator: false,
      isScrollControlled: true,
      enableDrag: isDismissible,
      isDismissible: isDismissible,
      barrierColor: AppColors.barrier,
      backgroundColor: AppColors.light,
      builder: (_) => this,
    );
  }
}
