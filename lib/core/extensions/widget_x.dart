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

  void openModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 12.0,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: false,
      isScrollControlled: true,
      barrierColor: AppColors.barrier,
      backgroundColor: AppColors.light,
      builder: (_) => this,
    );
  }
}

extension ContextX on BuildContext {
  void openSnackBar(String message) {
    Scaffold.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: AppTextStyles.small.light,
          ),
        ),
      );
  }
}
