import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:sahayatri/app/constants/resources.dart';

import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/user_location.dart';
import 'package:sahayatri/core/models/nearby_device.dart';

import 'package:nearby_connections/nearby_connections.dart';

class NearbyService {
  /// Topology of the network.
  final Strategy kStrategy = Strategy.P2P_STAR;

  /// Username identifying this device.
  final String _username = Random().nextInt(10000).toString();
  String get username => _username;

  /// List of connected devices.
  final List<NearbyDevice> _connectedDevices = [];
  List<NearbyDevice> get connected => _connectedDevices.toList();

  /// Called when device list changes.
  void Function() onDeviceChanged;

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

  /// Stop nearby service and disconnect from all devices.
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
  void onDisconnected(String id) {
    _removeDevice(id);
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

  /// Called when payload is sent from connected devices.
  void onPayLoadRecieved(String id, Payload payload) {
    final payloadJson = String.fromCharCodes(payload.bytes);
    final parsedPayload = jsonDecode(payloadJson);
    final userLocation = UserLocation.fromMap(parsedPayload as Map<String, dynamic>);

    final recipientDevice = _findDevice(id);
    if (recipientDevice != null) recipientDevice.userLocation = userLocation;
  }

  /// Called when payload is received on this device.
  void onPayloadTransferUpdate(String id, PayloadTransferUpdate payloadTransferUpdate) {}

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
  Future<void> broadcastLocation(UserLocation userLocation) async {
    final String payload = jsonEncode(userLocation.toMap());

    for (final device in _connectedDevices) {
      Nearby().sendBytesPayload(device.id, Uint8List.fromList(payload.codeUnits));
    }
  }
}
