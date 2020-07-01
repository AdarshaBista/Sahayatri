import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:sahayatri/app/constants/resources.dart';

import 'package:sahayatri/core/models/coord.dart';

class UserAlertService {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  bool isAlreadyAlerted = false;

  UserAlertService() {
    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const initializationSettingsIOS = IOSInitializationSettings();
    const initializationSettings = InitializationSettings(
      initializationSettingsAndroid,
      initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  bool shouldAlertUser(Coord userLocation, List<Coord> route) {
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
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      NotificationChannels.kOffRouteId,
      NotificationChannels.kOffRouteName,
      NotificationChannels.kOffRouteDesc,
      priority: Priority.Max,
      importance: Importance.Max,
      visibility: NotificationVisibility.Public,
    );
    const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    const platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Sahayatri - Off Route',
      'You seem to be going off route. Please reevaluate your course.',
      platformChannelSpecifics,
    );
  }
}
