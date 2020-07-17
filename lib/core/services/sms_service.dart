import 'dart:io';

import 'package:meta/meta.dart';

import 'package:sms_maintained/sms.dart';

import 'package:sahayatri/app/constants/resources.dart';
import 'package:sahayatri/app/constants/notification_channels.dart';

import 'package:sahayatri/app/database/prefs_dao.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/place.dart';

import 'package:sahayatri/core/utils/geo_utils.dart';
import 'package:sahayatri/core/services/notification_service.dart';

class SmsService {
  final PrefsDao prefsDao;
  final SmsSender sender = SmsSender();
  final NotificationService notificationService;

  /// List of ids of [Place] for which sms has already been sent.
  final List<int> _sentList = [];

  /// Phone number of close contact.
  String contact;

  SmsService({
    @required this.prefsDao,
    @required this.notificationService,
  })  : assert(prefsDao != null),
        assert(notificationService != null);

  /// Returns true if sms should be sent on arrival to [place].
  bool _shouldSend(Coord userLocation, Place place) {
    if (place == null || _sentList.contains(place?.id)) return false;
    final distance = GeoUtils.computeDistance(userLocation, place.coord);
    return distance < Distances.kMinNearbyDistance;
  }

  /// Send SMS to notify close contact of the user
  /// on his/her arrival at a [place].
  Future<void> send(Coord userLocation, Place place) async {
    if (Platform.isWindows) return;
    if (!_shouldSend(userLocation, place)) return;

    contact ??= (await prefsDao.get()).contact;
    if (contact.isEmpty) return;

    // TODO: Remove this
    _alert('$contact has been notified on your arrival at ${place.name}');

    final smsMessage = SmsMessage(contact, 'I have safely reached ${place.name}');
    smsMessage.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        _alert('$contact has been notified on your arrival at ${place.name}');
      } else if (state == SmsMessageState.Fail) {
        _alert('Failed to send message to $contact');
      }
    });

    try {
      // TODO: Enable sms
      // sender.sendSms(smsMessage);
    } catch (e) {
      print(e);
      return;
    }
    _sentList.add(place.id);
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
  void stop() {
    _sentList.clear();
  }
}
