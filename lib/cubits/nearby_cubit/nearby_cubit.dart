import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/nearby_device.dart';

import 'package:sahayatri/core/services/nearby/nearby_service.dart';

part 'nearby_state.dart';

class NearbyCubit extends Cubit<NearbyState> {
  final NearbyService nearbyService;

  NearbyCubit({
    @required this.nearbyService,
  })  : assert(nearbyService != null),
        super(const NearbyInitial());

  String get username => nearbyService.connectionService.username;

  void sendSos() => nearbyService.messagesService.broadcastSos();

  Future<void> startNearby(String name) async {
    try {
      emit(NearbyConnected(nearbyDevices: nearbyService.devices));
      nearbyService.devicesService.onDeviceChanged = changeDevice;
      await nearbyService.stop();
      await nearbyService.start(name);
    } on AppError catch (e) {
      emit(NearbyError(message: e.message));
      emit(const NearbyInitial());
    }
  }

  Future<void> stopNearby() async {
    emit(const NearbyInitial());
    await nearbyService.stop();
  }

  Future<void> startScanning() async {
    emit(NearbyConnected(nearbyDevices: nearbyService.devices));
    await nearbyService.connectionService.startScanning();
  }

  Future<void> stopScanning() async {
    emit(NearbyConnected(isScanning: false, nearbyDevices: nearbyService.devices));
    await nearbyService.connectionService.stopScanning();
  }

  Future<void> changeDevice() async {
    emit(NearbyConnected(
      nearbyDevices: nearbyService.devices,
      isScanning: (state as NearbyConnected).isScanning,
    ));
  }

  Future<void> removeDevice(NearbyDevice device) async {
    nearbyService.devicesService.removeDevice(device);
    emit(NearbyConnected(
      nearbyDevices: nearbyService.devices,
      isScanning: (state as NearbyConnected).isScanning,
    ));
  }
}
