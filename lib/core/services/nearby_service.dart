import 'dart:convert';
import 'dart:typed_data';

import 'package:meta/meta.dart';

import 'package:nearby_connections/nearby_connections.dart';

import 'package:sahayatri/app/constants/configs.dart';
import 'package:sahayatri/app/constants/notification_channels.dart';

import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/user_location.dart';
import 'package:sahayatri/core/models/nearby_device.dart';
import 'package:sahayatri/core/models/nearby_message.dart';

import 'package:sahayatri/core/services/notification_service.dart';

class NearbyService {
  final NotificationService notificationService;

  /// Topology of the network.
  final Strategy kStrategy = Strategy.P2P_STAR;

  /// Username identifying this device.
  String _username;
  String get username => _username;

  /// List of connected devices.
  final List<NearbyDevice> _connectedDevices = [];
  List<NearbyDevice> get connected => _connectedDevices.toList();

  /// Called when device list changes.
  void Function() onDeviceChanged;

  NearbyService({
    @required this.notificationService,
  }) : assert(notificationService != null);

  /// Start nearby service.
  Future<void> start(String name) async {
    _username = name;
    await startScanning();
  }

  /// Start scanning (advertising and discovery) process.
  Future<void> startScanning() async {
    await startAdvertising();
    await startDiscovery();
  }

  /// Stop scanning (advertising and discovery) process.
  Future<void> stopScanning() async {
    await Nearby().stopDiscovery();
    await Nearby().stopAdvertising();
  }

  /// Stop scanning and disconnect from all devices.
  Future<void> stop() async {
    await stopScanning();
    await Nearby().stopAllEndpoints();
    _connectedDevices.clear();
  }

  /// Start advertising to potential discoverers.
  Future<void> startAdvertising() async {
    try {
      await Nearby().startAdvertising(
        username,
        kStrategy,
        serviceId: AppConfig.kPackageName,
        onDisconnected: onDisconnected,
        onConnectionResult: onConnectionResult,
        onConnectionInitiated: onConnectionInit,
      );
    } catch (e) {
      print(e.toString());
      throw Failure(error: e.toString());
    }
  }

  /// Start discovering potential advertisers.
  Future<void> startDiscovery() async {
    try {
      await Nearby().startDiscovery(
        username,
        kStrategy,
        serviceId: AppConfig.kPackageName,
        onEndpointLost: onEndpointLost,
        onEndpointFound: onEndpointFound,
      );
    } catch (e) {
      print(e.toString());
      throw Failure(error: e.toString());
    }
  }

  /// Called when a connection is requested.
  Future<void> onConnectionInit(String id, ConnectionInfo info) async {
    try {
      await Nearby().acceptConnection(
        id,
        onPayLoadRecieved: onPayLoadRecieved,
        onPayloadTransferUpdate: onPayloadTransferUpdate,
      );
      _addDevice(id, info.endpointName);
    } catch (e) {
      print(e.toString());
    }
  }

  /// Called when connection is accepted or rejected.
  Future<void> onConnectionResult(String id, Status status) async {
    if (status != Status.CONNECTED) _removeDevice(id);
  }

  /// Called when a device disconnects.
  /// Alert other devices about the lost connection.
  void onDisconnected(String id) {
    _removeDevice(id);

    final device = _findDevice(id);
    final alertMessage = '${device.name} has disconnected from network.';

    notificationService.show(
      NotificationChannels.kDeviceDisconnectedId,
      alertMessage,
      channelId: NotificationChannels.kDeviceDisconnectedChannelId,
      channelName: NotificationChannels.kDeviceDisconnectedChannelName,
      channelDescription: NotificationChannels.kDeviceDisconnectedChannelDesc,
    );
  }

  /// Called (by discoverer) when nearby device is found.
  Future<void> onEndpointFound(String id, String name, String serviceId) async {
    await stopScanning();

    try {
      await Nearby().requestConnection(
        username,
        id,
        onDisconnected: onDisconnected,
        onConnectionResult: onConnectionResult,
        onConnectionInitiated: onConnectionInit,
      );
      await startScanning();
    } catch (e) {
      print(e.toString());
    }
  }

  /// Called (by discoverer) when nearby device is lost.
  void onEndpointLost(String id) {}

  /// Called when payload is received on this device.
  void onPayloadTransferUpdate(String id, PayloadTransferUpdate payloadTransferUpdate) {}

  /// Called when payload is sent from connected devices.
  /// Parses the incoming bytes and handles message according to [NearbyMessageType].
  void onPayLoadRecieved(String id, Payload payload) {
    final payloadStr = String.fromCharCodes(payload.bytes);
    final NearbyMessage message = _splitMessage(payloadStr);

    switch (message.type) {
      case NearbyMessageType.kSos:
        _showSosNotification(id);
        break;

      case NearbyMessageType.kChat:
        _handleIncomingChatMessage(id, message.body);
        break;

      case NearbyMessageType.kLocation:
        _handleIncomingLocation(id, message.body);
        break;

      default:
        break;
    }
  }

  /// Splits the raw message string into type and body.
  NearbyMessage _splitMessage(String payloadStr) {
    final payloadChunks = payloadStr.trim().split(NearbyMessageType.kSeparator);
    final messageType = payloadChunks[0];
    payloadChunks.removeAt(0);
    final messageBody = payloadChunks.join(NearbyMessageType.kSeparator);

    return NearbyMessage(
      type: messageType,
      body: messageBody,
    );
  }

  /// Show a SOS signal notification.
  void _showSosNotification(String id) {
    final device = _findDevice(id);
    final alertMessage = '${device.name} has sent a SOS signal.';

    notificationService.show(
      NotificationChannels.kSosId,
      alertMessage,
      channelId: NotificationChannels.kSosChannelId,
      channelName: NotificationChannels.kSosChannelName,
      channelDescription: NotificationChannels.kSosChannelDesc,
    );
  }

  /// Parses incoming caht message and updates corresponding device.
  void _handleIncomingChatMessage(String deviceId, String message) {}

  /// Parses incoming user location data and updates corresponding device.
  void _handleIncomingLocation(String deviceId, String message) {
    final parsedMessage = jsonDecode(message);
    final userLocation = UserLocation.fromMap(parsedMessage as Map<String, dynamic>);
    final recipientDevice = _findDevice(deviceId);
    if (recipientDevice != null) recipientDevice.userLocation = userLocation;
  }

  /// Add a [NearbyDevice] to connected list.
  void _addDevice(String id, String name) {
    _connectedDevices.add(
      NearbyDevice(
        id: id,
        name: name,
      ),
    );
    onDeviceChanged();
  }

  /// Remove a [NearbyDevice] from connected list.
  void _removeDevice(String id) {
    _connectedDevices.removeWhere((d) => d.id == id);
    onDeviceChanged();
  }

  /// Find [NearbyDevice] with given [id]
  NearbyDevice _findDevice(String id) {
    return connected.firstWhere((d) => d.id == id, orElse: () => null);
  }

  /// Broadcast this device's location to connected devices.
  void broadcastLocation(UserLocation userLocation) {
    final String locationJson = jsonEncode(userLocation.toMap());
    final String payload =
        NearbyMessageType.kLocation + NearbyMessageType.kSeparator + locationJson;

    for (final device in _connectedDevices) {
      Nearby().sendBytesPayload(device.id, Uint8List.fromList(payload.codeUnits));
    }
  }

  /// Send SOS signal to connected devices.
  void broadcastSos() {
    for (final device in _connectedDevices) {
      Nearby().sendBytesPayload(
        device.id,
        Uint8List.fromList(NearbyMessageType.kSos.codeUnits),
      );
    }
  }

  /// Send [message] to given [id].
  void sendMessage(String id, String message) {
    final String payload =
        NearbyMessageType.kChat + NearbyMessageType.kSeparator + message;
    final recipient = _findDevice(id);
    Nearby().sendBytesPayload(recipient.id, Uint8List.fromList(payload.codeUnits));
  }
}
