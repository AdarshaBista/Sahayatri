import 'dart:convert';
import 'dart:typed_data';

import 'package:nearby_connections/nearby_connections.dart';

import 'package:sahayatri/core/models/user_location.dart';
import 'package:sahayatri/core/models/nearby_message.dart';

import 'package:sahayatri/core/services/notification_service.dart';
import 'package:sahayatri/core/services/nearby/devices_service.dart';

import 'package:sahayatri/app/constants/configs.dart';
import 'package:sahayatri/app/constants/notification_channels.dart';

class MessagesService {
  final DevicesService devicesService;
  final NotificationService notificationService;

  const MessagesService(this.devicesService, this.notificationService);

  /// Called when payload is sent from connected devices.
  /// Parses the incoming bytes and handles message according to [NearbyMessageType].
  void onPayLoadRecieved(String id, Payload payload) {
    final payloadStr = String.fromCharCodes(payload.bytes);
    final message = _parseRawMessage(payloadStr);

    switch (message.type) {
      case NearbyMessageType.kSos:
        _showSosNotification(id);
        break;

      case NearbyMessageType.kLocation:
        _handleIncomingLocation(id, message.body);
        break;

      default:
        break;
    }
  }

  /// Called when payload is received on this device.
  /// Irrelevant when payload type is [PayloadType.BYTES]
  void onPayloadTransferUpdate(String id, PayloadTransferUpdate payloadTransferUpdate) {}

  /// Parses the raw message string into [NearbyMessage].
  NearbyMessage _parseRawMessage(String payloadStr) {
    final payloadChunks = payloadStr.trim().split(NearbyMessageType.kSeparator);
    final messageType = payloadChunks[0];
    payloadChunks.removeAt(0);
    final messageBody = payloadChunks.join(NearbyMessageType.kSeparator);

    return NearbyMessage(
      type: messageType,
      body: messageBody,
    );
  }

  /// Broadcast this device's location to connected devices.
  void broadcastLocation(UserLocation userLocation) {
    final String locationJson = jsonEncode(userLocation.toMap());
    final String payload =
        NearbyMessageType.kLocation + NearbyMessageType.kSeparator + locationJson;

    for (final device in devicesService.devices) {
      Nearby().sendBytesPayload(device.id, Uint8List.fromList(payload.codeUnits));
    }
  }

  /// Parses incoming user location data and updates corresponding device.
  void _handleIncomingLocation(String deviceId, String message) {
    final sender = devicesService.findDevice(deviceId);
    if (sender == null) return;

    final parsedMessage = jsonDecode(message);
    final userLocation = UserLocation.fromMap(parsedMessage as Map<String, dynamic>);
    sender.userLocation = userLocation;
    devicesService.onDeviceChanged();
  }

  /// Send SOS signal to connected devices.
  void broadcastSos() {
    const String payload = NearbyMessageType.kSos;
    for (final device in devicesService.devices) {
      Nearby().sendBytesPayload(
        device.id,
        Uint8List.fromList(payload.codeUnits),
      );
    }
  }

  /// Show a SOS signal notification.
  void _showSosNotification(String id) {
    final device = devicesService.findDevice(id);
    if (device == null) return;
    final alertMessage = '${device.name} has sent a SOS signal.';

    notificationService.show(
      NotificationChannels.kSosId,
      alertMessage,
      channelId: NotificationChannels.kSosChannelId,
      channelName: NotificationChannels.kSosChannelName,
      channelDescription: NotificationChannels.kSosChannelDesc,
    );
  }

  /// Show notification when device is disconnected
  void showDisconnectedNotification(String id) {
    final deviceName = devicesService.findDevice(id).name;
    final alertMessage = '$deviceName has disconnected from network.';

    notificationService.show(
      NotificationChannels.kDeviceDisconnectedId,
      alertMessage,
      channelId: NotificationChannels.kDeviceDisconnectedChannelId,
      channelName: NotificationChannels.kDeviceDisconnectedChannelName,
      channelDescription: NotificationChannels.kDeviceDisconnectedChannelDesc,
    );
  }
}
