import 'dart:io';

import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/nearby_device.dart';

import 'package:sahayatri/core/services/notification_service.dart';
import 'package:sahayatri/core/services/nearby/devices_service.dart';
import 'package:sahayatri/core/services/nearby/messsages_service.dart';
import 'package:sahayatri/core/services/nearby/connection_service.dart';

class NearbyService {
  /// Service to manage list of nearby devices.
  DevicesService devicesService;

  /// Service to handle incoming and outgoing nearby messages.
  MessagesService messagesService;

  /// Service to initiate and close connections to nearby devices.
  ConnectionService connectionService;

  /// Wheather nearby service is runnig or not.
  bool _isRunning = false;

  /// List of nearby devices.
  List<NearbyDevice> get devices => devicesService.devices;

  NearbyService({
    @required NotificationService notificationService,
  }) : assert(notificationService != null) {
    devicesService = DevicesService();
    messagesService = MessagesService(devicesService, notificationService);
    connectionService = ConnectionService(devicesService, messagesService);
  }

  /// Start nearby service.
  Future<void> start(String name) async {
    if (Platform.isWindows) throw const AppError(message: 'Platform not supported!');

    connectionService.username = name;
    try {
      await connectionService.checkLocationPermissions();
      await connectionService.startScanning();
    } on AppError {
      rethrow;
    }
    _isRunning = true;
  }

  /// Stop scanning and disconnect from all devices.
  Future<void> stop() async {
    if (!_isRunning) return;

    await connectionService.stopScanning();
    await connectionService.stopAll();
    devicesService.clear();
    _isRunning = false;
  }
}
