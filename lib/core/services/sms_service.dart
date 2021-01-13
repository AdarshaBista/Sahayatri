import 'dart:io';

import 'package:sahayatri/locator.dart';

import 'package:sms_maintained/sms.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/models/tracker_data.dart';

import 'package:sahayatri/core/utils/geo_utils.dart';
import 'package:sahayatri/core/services/notification_service.dart';

import 'package:sahayatri/core/constants/configs.dart';
import 'package:sahayatri/core/constants/notification_channels.dart';

import 'package:sahayatri/app/database/prefs_dao.dart';
import 'package:sahayatri/app/database/tracker_dao.dart';

class SmsService {
  final SmsSender sender = SmsSender();
  final PrefsDao prefsDao = locator();
  final TrackerDao trackerDao = locator();
  final NotificationService notificationService = locator();

  /// List of ids of [Place] for which sms has already been sent in this session.
  final List<String> _sentList = [];

  /// Phone number of close contact.
  String contact;

  /// Persisted tracker data.
  TrackerData trackerData;

  /// Returns true if sms should be sent on arrival to [checkpoint].
  Future<bool> _shouldSend(Coord userLocation, Checkpoint checkpoint) async {
    if (Platform.isWindows) return false;

    if (checkpoint == null ||
        !checkpoint.notifyContact ||
        _sentList.contains(checkpoint.place.id)) {
      return false;
    }

    final distance = GeoUtils.computeDistance(userLocation, checkpoint.place.coord);
    if (distance > LocationConfig.minNearbyDistance) return false;

    trackerData = await trackerDao.get();
    return !trackerData.smsSentList.contains(checkpoint.place.id);
  }

  /// Send SMS to notify close contact of the user
  /// on his/her arrival at a [checkpoint].
  Future<void> send(Coord userLocation, Checkpoint checkpoint) async {
    if (!await _shouldSend(userLocation, checkpoint)) return;

    contact ??= (await prefsDao.get()).contact;
    if (contact.isEmpty) return;

    final place = checkpoint.place;
    _alert('$contact has been notified on your arrival at ${place.name}');
    final smsMessage = SmsMessage(
      contact,
      'I have safely reached ${place.name}',
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
    await _updateTrackerData(place);
  }

  Future<void> _updateTrackerData(Place place) async {
    trackerData = trackerData.copyWith(
      smsSentList: [...trackerData.smsSentList, place.id],
    );
    await trackerDao.upsert(trackerData);
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
