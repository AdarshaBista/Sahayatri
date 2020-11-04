import 'package:nearby_connections/nearby_connections.dart';

import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/nearby_device.dart';

import 'package:sahayatri/core/services/nearby/devices_service.dart';
import 'package:sahayatri/core/services/nearby/messsages_service.dart';

import 'package:sahayatri/app/constants/configs.dart';

class ConnectionService {
  final DevicesService devicesService;
  final MessagesService messagesService;

  /// Topology of the network.
  final Strategy _strategy = Strategy.P2P_CLUSTER;

  /// Username identifying this device.
  String username;

  ConnectionService(this.devicesService, this.messagesService);

  /// Check location permissions on start.
  Future<void> checkLocationPermissions() async {
    try {
      if (!await Nearby().checkLocationPermission()) {
        Nearby().askLocationPermission();
      }
      if (!await Nearby().checkLocationEnabled()) {
        Nearby().enableLocationServices();
      }
    } catch (e) {
      print(e.toString());
      throw const AppError(message: 'Please allow location permissions.');
    }
  }

  /// Start scanning (advertising and discovery) process.
  Future<void> startScanning() async {
    try {
      await _startAdvertising();
      await _startDiscovery();
    } on AppError {
      rethrow;
    }
  }

  /// Stop scanning (advertising and discovery) process.
  Future<void> stopScanning() async {
    try {
      await Nearby().stopDiscovery();
      await Nearby().stopAdvertising();
    } catch (e) {
      print(e.toString());
      throw const AppError(message: 'Cannot initiate scanning.');
    }
  }

  /// Start advertising to potential discoverers.
  Future<void> _startAdvertising() async {
    try {
      await Nearby().startAdvertising(
        username,
        _strategy,
        serviceId: AppConfig.packageName,
        onDisconnected: _onDisconnected,
        onConnectionResult: _onConnectionResult,
        onConnectionInitiated: _onConnectionInit,
      );
    } catch (e) {
      print(e.toString());
      throw const AppError(message: 'Cannot start advertising.');
    }
  }

  /// Start discovering potential advertisers.
  Future<void> _startDiscovery() async {
    try {
      await Nearby().startDiscovery(
        username,
        _strategy,
        serviceId: AppConfig.packageName,
        onEndpointLost: _onEndpointLost,
        onEndpointFound: _onEndpointFound,
      );
    } catch (e) {
      print(e.toString());
      throw const AppError(message: 'Cannot start discovery.');
    }
  }

  /// Called (by discoverer) when nearby device is found.
  Future<void> _onEndpointFound(String id, String name, String serviceId) async {
    final device = devicesService.findDevice(id);
    if (device != null) return;

    await stopScanning();
    try {
      await Nearby().requestConnection(
        username,
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
    devicesService.addDevice(id, info.endpointName);
    try {
      await Nearby().acceptConnection(
        id,
        onPayLoadRecieved: messagesService.onPayLoadRecieved,
        onPayloadTransferUpdate: messagesService.onPayloadTransferUpdate,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  /// Called when connection is accepted or rejected (after [_onConnectionInit]).
  void _onConnectionResult(String id, Status status) {
    if (status == Status.CONNECTED) {
      devicesService.updateDeviceStatus(id, DeviceStatus.connected);
    } else {
      devicesService.updateDeviceStatus(id, DeviceStatus.disconnected);
    }
  }

  /// Called when a device disconnects.
  /// Removes the disconnected device from [_nearbydevices] and
  /// alerts other devices about the lost connection.
  void _onDisconnected(String id) {
    devicesService.updateDeviceStatus(id, DeviceStatus.disconnected);
    messagesService.showDisconnectedNotification(id);
  }

  Future<void> stopAll() async {
    await Nearby().stopAllEndpoints();
  }
}
