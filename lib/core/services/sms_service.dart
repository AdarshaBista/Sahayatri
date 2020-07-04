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
  final NotificationService notificationService;

  final SmsSender sender = SmsSender();
  final List<int> _sentList = [];

  SmsService({
    @required this.prefsDao,
    @required this.notificationService,
  })  : assert(prefsDao != null),
        assert(notificationService != null);

  bool shouldSend(Coord userLocation, Place nextStop) {
    if (nextStop == null || _sentList.contains(nextStop?.id)) return false;

    final distance = SphericalUtil.computeDistanceBetween(
      LatLng(userLocation.lat, userLocation.lng),
      LatLng(nextStop.coord.lat, nextStop.coord.lng),
    );
    return distance < Distances.kMinNearbyDistance * 2.0;
  }

  Future<void> send(Place place) async {
    if (Platform.isWindows) return;

    final String contact = (await prefsDao.get()).contact;
    final message = SmsMessage(contact, 'I have safely reached ${place.name}');
    message.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        _alert('$contact has been notified of your arrival at ${place.name}');
      } else if (state == SmsMessageState.Fail) {
        _alert('Failed to send sms to $contact');
      }
    });

    try {
      // TODO: Remove this check
      if (place.id == 13) sender.sendSms(message);
    } catch (e) {
      print(e);
      return;
    }
    _sentList.add(place.id);
  }

  Future<void> _alert(String message) async {
    await notificationService.show(
      NotificationChannels.kSmsSentId,
      message,
      channelId: NotificationChannels.kSmsSentChannelId,
      channelName: NotificationChannels.kSmsSentChannelName,
      channelDescription: NotificationChannels.kSmsSentChannelDesc,
    );
  }

  void clear() {
    _sentList.clear();
  }
}
