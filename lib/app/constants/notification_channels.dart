class NotificationChannels {
  // Off-Route
  static const int kOffRouteId = 0;
  static const String kOffRouteChannelId = 'off_route';
  static const String kOffRouteChannelName = 'Off Route Alert';
  static const String kOffRouteChannelDesc = 'Notify when user goes off-route';

  // SMS
  static const int kSmsSentId = 1;
  static const String kSmsSentChannelId = 'sms_sent';
  static const String kSmsSentChannelName = 'Sms Sent';
  static const String kSmsSentChannelDesc = 'Notify when sms is sent';

  // SOS
  static const int kSosId = 2;
  static const String kSosChannelId = 'sos';
  static const String kSosChannelName = 'SOS Signal';
  static const String kSosChannelDesc =
      'Notify when SOS signal is received from other devices';

  // SOS
  static const int kChatId = 3;
  static const String kChatChannelId = 'chat';
  static const String kChatChannelName = 'Chat Message Received';
  static const String kChatChannelDesc = 'Notify when chat message is received';

  // SOS
  static const int kDeviceDisconnectedId = 4;
  static const String kDeviceDisconnectedChannelId = 'device_disconnected';
  static const String kDeviceDisconnectedChannelName = 'Device Disconnected';
  static const String kDeviceDisconnectedChannelDesc =
      'Notify when device is disconnected from nearby network';
}
