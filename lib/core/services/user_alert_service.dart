import 'package:meta/meta.dart';

import 'package:maps_toolkit/maps_toolkit.dart';

import 'package:sahayatri/app/constants/resources.dart';
import 'package:sahayatri/app/constants/notification_channels.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:sahayatri/core/services/notification_service.dart';

class UserAlertService {
  final NotificationService notificationService;
  bool isAlreadyAlerted = false;

  UserAlertService({
    @required this.notificationService,
  }) : assert(notificationService != null);

  bool shouldAlert(Coord userLocation, List<Coord> route) {
    final bool isOnRoute = PolygonUtil.isLocationOnPath(
      LatLng(userLocation.lat, userLocation.lng),
      route.map((l) => LatLng(l.lat, l.lng)).toList(),
      false,
      tolerance: Distances.kMinNearbyDistance,
    );

    if (!isOnRoute && isAlreadyAlerted) return false;
    if (!isOnRoute && !isAlreadyAlerted) return isAlreadyAlerted = true;
    return isAlreadyAlerted = false;
  }

  Future<void> alert() async {
    await notificationService.show(
      NotificationChannels.kOffRouteId,
      'You seem to be going off route. Please re-evaluate your course.',
      channelId: NotificationChannels.kOffRouteChannelId,
      channelName: NotificationChannels.kOffRouteChannelName,
      channelDescription: NotificationChannels.kOffRouteChannelDesc,
    );
  }
}
