import 'dart:io';

import 'package:meta/meta.dart';

import 'package:sms_maintained/sms.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/checkpoint.dart';

import 'package:sahayatri/core/utils/geo_utils.dart';
import 'package:sahayatri/core/services/notification_service.dart';

import 'package:sahayatri/app/constants/configs.dart';
import 'package:sahayatri/app/constants/notification_channels.dart';

import 'package:sahayatri/app/database/prefs_dao.dart';

class SmsService {
  final PrefsDao prefsDao;
  final SmsSender sender = SmsSender();
  final NotificationService notificationService;

  /// List of ids of [Place] for which sms has already been sent.
  final List<String> _sentList = [];

  /// Phone number of close contact.
  String contact;

  SmsService({
    @required this.prefsDao,
    @required this.notificationService,
  })  : assert(prefsDao != null),
        assert(notificationService != null);

  /// Returns true if sms should be sent on arrival to [place].
  bool _shouldSend(Coord userLocation, Checkpoint checkpoint) {
    if (checkpoint == null ||
        !checkpoint.notifyContact ||
        _sentList.contains(checkpoint.place.id)) return false;
    final distance = GeoUtils.computeDistance(userLocation, checkpoint.place.coord);
    return distance < LocationConfig.minNearbyDistance;
  }

  /// Send SMS to notify close contact of the user
  /// on his/her arrival at a [place].
  Future<void> send(Coord userLocation, Checkpoint checkpoint) async {
    if (Platform.isWindows) return;
    if (!_shouldSend(userLocation, checkpoint)) return;

    contact ??= (await prefsDao.get()).contact;
    if (contact.isEmpty) return;

    final place = checkpoint.place;
    _alert('$contact has been notified on your arrival at ${place.name}');
    final smsMessage = SmsMessage(
      contact,
      '${AppConfig.smsMessagePrefix} ${place.name}',
    );

    smsMessage.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        _alert('$contact has been notified on your arrival at ${place.name}');
      } else if (state == SmsMessageState.Fail) {
        _alert('Failed to send message to $contact');
      }
    });

    try {
      // sender.sendSms(smsMessage);
    } catch (e) {
      print(e.toString());
      return;
    }
    _sentList.add(place.id);
  }

  /// Show notification to user on status of sms.
  Future<void> _alert(String message) async {
    await notificationService.show(
      NotificationChannels.smsSentId,
      message,
      channelId: NotificationChannels.smsSentChannelId,
      channelName: NotificationChannels.smsSentChannelName,
      channelDescription: NotificationChannels.smsSentChannelDesc,
    );
  }

  /// Clear sms sent list once tracking is over.
  void stop() {
    _sentList.clear();
  }
}
