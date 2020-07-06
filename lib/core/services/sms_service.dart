import 'dart:io';

import 'package:meta/meta.dart';

import 'package:sms_maintained/sms.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

import 'package:sahayatri/app/constants/resources.dart';
import 'package:sahayatri/app/constants/notification_channels.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/place.dart';

import 'package:sahayatri/core/database/prefs_dao.dart';

import 'package:sahayatri/core/services/notification_service.dart';

class SmsService {
  final PrefsDao prefsDao;
  final SmsSender sender = SmsSender();
  final NotificationService notificationService;

  /// List of ids of [Place] for which sms has already been sent.
  final List<int> _sentList = [];

  SmsService({
    @required this.prefsDao,
    @required this.notificationService,
  })  : assert(prefsDao != null),
        assert(notificationService != null);

  /// Returns true if sms should be sent on arrival to [nextStop].
  bool _shouldSend(Coord userLocation, Place nextStop) {
    if (nextStop == null || _sentList.contains(nextStop?.id)) return false;

    final distance = SphericalUtil.computeDistanceBetween(
      LatLng(userLocation.lat, userLocation.lng),
      LatLng(nextStop.coord.lat, nextStop.coord.lng),
    );
    return distance < Distances.kMinNearbyDistance * 2.0;
  }

  /// Send SMS to notify close contact of the user
  /// on his/her arrival at a [place].
  Future<void> send(Coord userLocation, Place nextStop) async {
    if (!_shouldSend(userLocation, nextStop)) return;
    if (Platform.isWindows) return;

    final contact = (await prefsDao.get()).contact;
    if (contact.isEmpty) return;

    final message = SmsMessage(contact, 'I have safely reached ${nextStop.name}');

    message.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        _alert('$contact has been notified of your arrival at ${nextStop.name}');
      } else if (state == SmsMessageState.Fail) {
        _alert('Failed to send sms to $contact');
      }
    });

    try {
      // TODO: Remove this check
      if (nextStop.id == 13) sender.sendSms(message);
    } catch (e) {
      print(e);
      return;
    }
    _sentList.add(nextStop.id);
  }

  /// Show notification to user on status of sms.
  Future<void> _alert(String message) async {
    await notificationService.show(
      NotificationChannels.kSmsSentId,
      message,
      channelId: NotificationChannels.kSmsSentChannelId,
      channelName: NotificationChannels.kSmsSentChannelName,
      channelDescription: NotificationChannels.kSmsSentChannelDesc,
    );
  }

  /// Clear sms sent list once tracking is over.
  void clear() {
    _sentList.clear();
  }
}
