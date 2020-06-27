import 'package:sahayatri/app/constants/values.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class UserAlertService {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  UserAlertService() {
    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const initializationSettingsIOS = IOSInitializationSettings();
    const initializationSettings = InitializationSettings(
      initializationSettingsAndroid,
      initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> alert() async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      Values.kOffRouteChannelId,
      Values.kOffRouteChannelName,
      Values.kOffRouteChannelDesc,
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
      'You seem to be going off route. Please check the route on the app.',
      platformChannelSpecifics,
    );
  }
}
