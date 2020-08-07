import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/nearby_device.dart';

import 'package:sahayatri/core/services/nearby_service.dart';

part 'nearby_state.dart';

class NearbyCubit extends Cubit<NearbyState> {
  final NearbyService nearbyService;

  NearbyCubit({
    @required this.nearbyService,
  })  : assert(nearbyService != null),
        super(const NearbyInitial());

  String get username => nearbyService.username;

  void sendSos() => nearbyService.broadcastSos();

  Future<void> startNearby(String name) async {
    try {
      emit(NearbyConnected(nearbyDevices: nearbyService.nearbyDevices));
      nearbyService.onDeviceChanged = changeDevice;
      await nearbyService.stop();
      await nearbyService.start(name);
    } on Failure catch (e) {
      emit(NearbyError(message: e.message));
      emit(const NearbyInitial());
    }
  }

  Future<void> stopNearby() async {
    emit(const NearbyInitial());
    await nearbyService.stop();
  }

  Future<void> startScanning() async {
    emit(NearbyConnected(nearbyDevices: nearbyService.nearbyDevices));
    await nearbyService.startScanning();
  }

  Future<void> stopScanning() async {
    emit(NearbyConnected(isScanning: false, nearbyDevices: nearbyService.nearbyDevices));
    await nearbyService.stopScanning();
  }

  Future<void> changeDevice() async {
    emit(NearbyConnected(
      nearbyDevices: nearbyService.nearbyDevices,
      isScanning: (state as NearbyConnected).isScanning,
    ));
  }

  Future<void> removeDevice(NearbyDevice device) async {
    nearbyService.removeDevice(device);
    emit(NearbyConnected(
      nearbyDevices: nearbyService.nearbyDevices,
      isScanning: (state as NearbyConnected).isScanning,
    ));
  }
}
