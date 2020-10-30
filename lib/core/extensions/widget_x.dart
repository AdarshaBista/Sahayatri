import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flushbar/flushbar.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/indicators/circular_busy_indicator.dart';

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

enum FlushbarType { info, success, error }

extension ContextX on BuildContext {
  Future<void> openLoadingFlushBar(String message, AsyncCallback callback) async {
    final flushBar = Flushbar(
      borderRadius: 8.0,
      isDismissible: false,
      blockBackgroundInteraction: true,
      margin: const EdgeInsets.all(16.0),
      backgroundColor: AppColors.darkAccent,
      flushbarPosition: FlushbarPosition.TOP,
      animationDuration: const Duration(milliseconds: 300),
      messageText: Text(message, style: AppTextStyles.small.light),
      icon: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularBusyIndicator(),
      ),
    );

    flushBar.show(this);
    await callback();
    flushBar.dismiss();
  }

  void openFlushBar(
    String message, {
    int ms = 2000,
    FlushbarType type = FlushbarType.info,
  }) {
    IconData getIcon() {
      switch (type) {
        case FlushbarType.info:
          return Icons.info_outline;
        case FlushbarType.success:
          return Icons.check_circle_outline;
        case FlushbarType.error:
          return Icons.error_outline;
        default:
          return Icons.circle;
      }
    }

    Color getColor() {
      switch (type) {
        case FlushbarType.info:
          return Colors.lightBlue;
        case FlushbarType.success:
          return AppColors.primaryDark;
        case FlushbarType.error:
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
