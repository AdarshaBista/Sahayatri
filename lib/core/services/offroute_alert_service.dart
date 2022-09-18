import 'package:sahayatri/core/constants/notification_channels.dart';
import 'package:sahayatri/core/services/notification_service.dart';

import 'package:sahayatri/locator.dart';

class OffRouteAlertService {
  bool isAlreadyAlerted = false;
  final NotificationService notificationService = locator();

  /// Returns true if user should be alerted.
  /// Do not alert the user if he/she has already been alerted once.
  bool _shouldAlert(bool isOnRoute) {
    if (!isOnRoute && isAlreadyAlerted) return false;
    if (!isOnRoute && !isAlreadyAlerted) return isAlreadyAlerted = true;
    return isAlreadyAlerted = false;
  }

  /// Show notification regarding off-route movement.
  Future<void> alert(bool isOnRoute) async {
    if (!_shouldAlert(isOnRoute)) return;

    const alertMessage = 'You seem to be going off route. Please re-evaluate your course.';

    await notificationService.show(
      NotificationChannels.offRouteId,
      alertMessage,
      channelId: NotificationChannels.offRouteChannelId,
      channelName: NotificationChannels.offRouteChannelName,
      channelDescription: NotificationChannels.offRouteChannelDesc,
    );
  }
}
