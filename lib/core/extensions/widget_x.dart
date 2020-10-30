import 'package:flutter/material.dart';

import 'package:flushbar/flushbar.dart';
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

enum FlushBarType { info, success, error }

extension ContextX on BuildContext {
  void openFlushBar(
    String message, {
    int ms = 2000,
    FlushBarType type = FlushBarType.info,
  }) {
    IconData getIcon() {
      switch (type) {
        case FlushBarType.info:
          return Icons.info_outline;
        case FlushBarType.success:
          return Icons.check_circle_outline;
        case FlushBarType.error:
          return Icons.error_outline;
        default:
          return Icons.info_outline;
      }
    }

    Color getColor() {
      switch (type) {
        case FlushBarType.info:
          return AppColors.light;
        case FlushBarType.success:
          return AppColors.primaryDark;
        case FlushBarType.error:
          return AppColors.secondary;
        default:
          return AppColors.light;
      }
    }

    final icon = getIcon();
    final color = getColor();

    Flushbar(
      borderRadius: 8.0,
      leftBarIndicatorColor: color,
      margin: const EdgeInsets.all(16.0),
      duration: Duration(milliseconds: ms),
      backgroundColor: AppColors.darkAccent,
      flushbarPosition: FlushbarPosition.TOP,
      icon: Icon(icon, color: color, size: 24.0),
      animationDuration: const Duration(milliseconds: 300),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      messageText: Text(message, style: AppTextStyles.small.withColor(color)),
    ).show(this);
  }
}
