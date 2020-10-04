import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService() {
    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const initializationSettingsIOS = IOSInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> show(
    int id,
    String message, {
    String channelId,
    String channelName,
    String channelDescription,
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription,
      priority: Priority.max,
      importance: Importance.max,
      visibility: NotificationVisibility.public,
    );
    const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      'Sahayatri',
      message,
      platformChannelSpecifics,
    );
  }
}
