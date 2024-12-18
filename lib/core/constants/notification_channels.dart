class NotificationChannels {
  // Notify when user goes off-route.
  static const int offRouteId = 0;
  static const String offRouteChannelId = 'off_route';
  static const String offRouteChannelName = 'Off Route Alert';
  static const String offRouteChannelDesc = 'Notify when user goes off-route';

  // Notify when sms is sent.
  static const int smsSentId = 1;
  static const String smsSentChannelId = 'sms_sent';
  static const String smsSentChannelName = 'Sms Sent';
  static const String smsSentChannelDesc = 'Notify when sms is sent';

  // Notify when SOS signal is received from other devices.
  static const int sosId = 2;
  static const String sosChannelId = 'sos';
  static const String sosChannelName = 'SOS Signal';
  static const String sosChannelDesc = 'Notify when SOS signal is received from other devices';

  // Notify when device is disconnected from nearby network.
  static const int deviceDisconnectedId = 3;
  static const String deviceDisconnectedChannelId = 'device_disconnected';
  static const String deviceDisconnectedChannelName = 'Device Disconnected';
  static const String deviceDisconnectedChannelDesc =
      'Notify when device is disconnected from nearby network';
}
