import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flushbar/flushbar.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/indicators/circular_busy_indicator.dart';

enum FlushbarType { info, success, error }
Flushbar _flushbar;

extension ContextX on BuildContext {
  Future<void> openLoadingFlushBar(
    String message, {
    AsyncCallback callback,
    bool isInteractive = true,
  }) async {
    _flushbar?.dismiss();

    _flushbar = Flushbar(
      borderRadius: 8.0,
      isDismissible: isInteractive,
      margin: const EdgeInsets.all(16.0),
      backgroundColor: AppColors.darkSurface,
      flushbarPosition: FlushbarPosition.TOP,
      blockBackgroundInteraction: !isInteractive,
      leftBarIndicatorColor: AppColors.primaryDark,
      animationDuration: const Duration(milliseconds: 300),
      messageText: Text(message, style: AppTextStyles.headline5.light),
      icon: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularBusyIndicator(),
      ),
    );

    _flushbar.show(this);
    await callback();
    _flushbar.dismiss();
  }

  void openFlushBar(
    String message, {
    FlushbarType type = FlushbarType.info,
  }) {
    _flushbar?.dismiss();

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

    _flushbar = Flushbar(
      borderRadius: 8.0,
      leftBarIndicatorColor: color,
      margin: const EdgeInsets.all(16.0),
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.darkSurface,
      flushbarPosition: FlushbarPosition.TOP,
      icon: Icon(icon, color: color, size: 24.0),
      animationDuration: const Duration(milliseconds: 300),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      messageText: Text(message, style: AppTextStyles.headline5.withColor(color)),
    );
    _flushbar.show(this);
  }
}
