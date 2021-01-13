import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

extension DialogX on Widget {
  void openDialog(BuildContext context, {bool barrierDismissible = true}) {
    showDialog(
      context: context,
      useSafeArea: true,
      useRootNavigator: false,
      barrierColor: AppColors.darkFaded,
      barrierDismissible: barrierDismissible,
      builder: (_) => this,
    );
  }

  PersistentBottomSheetController openBottomSheet(BuildContext context) {
    return showBottomSheet(
      context: context,
      elevation: 12.0,
      clipBehavior: Clip.antiAlias,
      builder: (_) => this,
    );
  }

  void openModalBottomSheet(BuildContext context, {bool enableDrag = true}) {
    showModalBottomSheet(
      context: context,
      elevation: 12.0,
      isDismissible: true,
      enableDrag: enableDrag,
      useRootNavigator: false,
      isScrollControlled: true,
      barrierColor: AppColors.darkFaded,
      builder: (_) => this,
    );
  }
}
