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
  final Strategy _kStrategy = Strategy.P2P_CLUSTER;

  /// Username identifying this device.
  String _username;
  String get username => _username;

  /// List of nearby devices.
  final Set<NearbyDevice> _nearbyDevices = {};
  List<NearbyDevice> get nearbyDevices => _nearbyDevices.toList();

  /// Called when a device is added to or updated in [_nearbyDevices].
  void Function() onDeviceChanged;

  NearbyService({
    @required this.notificationService,
  }) : assert(notificationService != null);

  /// Start nearby service.
  Future<void> start(String name) async {
    _username = name;

    if (!await Nearby().checkLocationEnabled()) Nearby().enableLocationServices();
    if (!await Nearby().checkLocationPermission()) Nearby().askLocationPermission();
    await startScanning();
  }

  /// Start scanning (advertising and discovery) process.
  Future<void> startScanning() async {
    await _startAdvertising();
    await _startDiscovery();
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
    _nearbyDevices.clear();
  }

  /// Start advertising to potential discoverers.
  Future<void> _startAdvertising() async {
    try {
      await Nearby().startAdvertising(
        _username,
        _kStrategy,
        serviceId: AppConfig.kPackageName,
        onDisconnected: _onDisconnected,
        onConnectionResult: _onConnectionResult,
        onConnectionInitiated: _onConnectionInit,
      );
    } catch (e) {
      throw Failure(error: e.toString());
    }
  }

  /// Start discovering potential advertisers.
  Future<void> _startDiscovery() async {
    try {
      await Nearby().startDiscovery(
        _username,
        _kStrategy,
        serviceId: AppConfig.kPackageName,
        onEndpointLost: _onEndpointLost,
        onEndpointFound: _onEndpointFound,
      );
    } catch (e) {
      throw Failure(error: e.toString());
    }
  }

  /// Called (by discoverer) when nearby device is found.
  Future<void> _onEndpointFound(String id, String name, String serviceId) async {
    final device = _findDevice(id);
    if (device != null) return;

    await stopScanning();
    try {
      await Nearby().requestConnection(
        _username,
        id,
        onDisconnected: _onDisconnected,
        onConnectionResult: _onConnectionResult,
        onConnectionInitiated: _onConnectionInit,
      );
    } catch (e) {
      print(e.toString());
    } finally {
      await startScanning();
    }
  }

  /// Called (by discoverer) when nearby device is lost.
  void _onEndpointLost(String id) {}

  /// Called when a connection is requested.
  Future<void> _onConnectionInit(String id, ConnectionInfo info) async {
    _addDevice(id, info.endpointName);
    try {
      await Nearby().acceptConnection(
        id,
        onPayLoadRecieved: _onPayLoadRecieved,
        onPayloadTransferUpdate: _onPayloadTransferUpdate,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  /// Called when connection is accepted or rejected (after [_onConnectionInit]).
  void _onConnectionResult(String id, Status status) {
    if (status == Status.CONNECTED) {
      final device = _findDevice(id);
      if (device == null) return;
      device.isConnecting = false;
      onDeviceChanged();
    } else {
      _removeDevice(id);
    }
  }

  /// Called when a device disconnects.
  /// Removes the disconnected device from [_nearbydevices] and
  /// alerts other devices about the lost connection.
  void _onDisconnected(String id) {
    final device = _findDevice(id);
    if (device == null) return;
    _removeDevice(id);
    _showDisconnectedNotification(device.name);
  }

  /// Called when payload is sent from connected devices.
  /// Parses the incoming bytes and handles message according to [NearbyMessageType].
  void _onPayLoadRecieved(String id, Payload payload) {
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
  void _onPayloadTransferUpdate(String id, PayloadTransferUpdate payloadTransferUpdate) {}

  /// Add a [NearbyDevice] to nearby devices set.
  void _addDevice(String id, String name) {
    _nearbyDevices.add(NearbyDevice(id: id, name: name));
    onDeviceChanged();
  }

  /// Remove a [NearbyDevice] from nearby devices set.
  void _removeDevice(String id) {
    final device = _findDevice(id);
    _nearbyDevices.remove(device);
    onDeviceChanged();
  }

  /// Find [NearbyDevice] with given [id]
  NearbyDevice _findDevice(String id) {
    return nearbyDevices.firstWhere((d) => d.id == id, orElse: () => null);
  }

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

    for (final device in nearbyDevices) {
      Nearby().sendBytesPayload(device.id, Uint8List.fromList(payload.codeUnits));
    }
  }

  /// Parses incoming user location data and updates corresponding device.
  void _handleIncomingLocation(String deviceId, String message) {
    final sender = _findDevice(deviceId);
    if (sender == null) return;

    final parsedMessage = jsonDecode(message);
    final userLocation = UserLocation.fromMap(parsedMessage as Map<String, dynamic>);
    sender.userLocation = userLocation;
    onDeviceChanged();
  }

  /// Send SOS signal to connected devices.
  void broadcastSos() {
    const String payload = NearbyMessageType.kSos;
    for (final device in nearbyDevices) {
      Nearby().sendBytesPayload(
        device.id,
        Uint8List.fromList(payload.codeUnits),
      );
    }
  }

  /// Show a SOS signal notification.
  void _showSosNotification(String id) {
    final device = _findDevice(id);
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
  void _showDisconnectedNotification(String name) {
    final alertMessage = '$name has disconnected from network.';

    notificationService.show(
      NotificationChannels.kDeviceDisconnectedId,
      alertMessage,
      channelId: NotificationChannels.kDeviceDisconnectedChannelId,
      channelName: NotificationChannels.kDeviceDisconnectedChannelName,
      channelDescription: NotificationChannels.kDeviceDisconnectedChannelDesc,
    );
  }
}
