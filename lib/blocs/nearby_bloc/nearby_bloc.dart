import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/nearby_device.dart';

import 'package:sahayatri/core/services/nearby_service.dart';

part 'nearby_event.dart';
part 'nearby_state.dart';

class NearbyBloc extends Bloc<NearbyEvent, NearbyState> {
  final NearbyService nearbyService;

  NearbyBloc({
    @required this.nearbyService,
  })  : assert(nearbyService != null),
        super(const NearbyInitial());

  String get username => nearbyService.username;

  void sendSos() => nearbyService.broadcastSos();

  @override
  Stream<NearbyState> mapEventToState(NearbyEvent event) async* {
    if (event is NearbyStarted) yield* _mapNearbyStartedToState(event.name);
    if (event is NearbyStopped) yield* _mapNearbyStoppedToState();
    if (event is ScanningStarted) yield* _mapScanningStartedToState();
    if (event is ScanningStopped) yield* _mapScanningStoppedToState();
    if (event is DeviceListChanged) yield* _mapDeviceChangedToState();
  }

  Stream<NearbyState> _mapNearbyStartedToState(String name) async* {
    try {
      nearbyService.stop();
      nearbyService.start(name);
      nearbyService.onDeviceListChanged = () => add(const DeviceListChanged());
      yield NearbyConnected(nearbyDevices: nearbyService.nearbyDevices);
    } on Failure catch (e) {
      yield NearbyError(message: e.message);
      yield const NearbyInitial();
    }
  }

  Stream<NearbyState> _mapNearbyStoppedToState() async* {
    nearbyService.stop();
    yield const NearbyInitial();
  }

  Stream<NearbyState> _mapScanningStartedToState() async* {
    nearbyService.startScanning();
    yield NearbyConnected(nearbyDevices: nearbyService.nearbyDevices);
  }

  Stream<NearbyState> _mapScanningStoppedToState() async* {
    nearbyService.stopScanning();
    yield NearbyConnected(
      isScanning: false,
      nearbyDevices: nearbyService.nearbyDevices,
    );
  }

  Stream<NearbyState> _mapDeviceChangedToState() async* {
    yield NearbyConnected(
      nearbyDevices: nearbyService.nearbyDevices,
      isScanning: (state as NearbyConnected).isScanning,
    );
  }
}
