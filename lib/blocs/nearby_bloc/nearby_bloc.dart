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

  @override
  Stream<NearbyState> mapEventToState(NearbyEvent event) async* {
    if (event is NearbyStarted) yield* _mapNearbyStartedToState();
    if (event is NearbyStopped) yield* _mapNearbyStoppedToState();
    if (event is ScanningStarted) yield* _mapScanningStartedToState();
    if (event is ScanningStopped) yield* _mapScanningStoppedToState();
    if (event is DeviceChanged) yield* _mapDeviceChangedToState();
  }

  Stream<NearbyState> _mapNearbyStartedToState() async* {
    try {
      yield NearbyInProgress(connected: nearbyService.connected);
      nearbyService.onDeviceChanged = () => add(const DeviceChanged());
      await nearbyService.stop();
      await nearbyService.startScanning();
    } on Failure catch (e) {
      yield NearbyError(message: e.message);
      yield const NearbyInitial();
    }
  }

  Stream<NearbyState> _mapNearbyStoppedToState() async* {
    await nearbyService.stop();
    yield const NearbyInitial();
  }

  Stream<NearbyState> _mapScanningStartedToState() async* {
    await nearbyService.startScanning();
    yield NearbyInProgress(connected: nearbyService.connected);
  }

  Stream<NearbyState> _mapScanningStoppedToState() async* {
    await nearbyService.stopScanning();
    yield NearbyInProgress(
      isScanning: false,
      connected: nearbyService.connected,
    );
  }

  Stream<NearbyState> _mapDeviceChangedToState() async* {
    yield NearbyInProgress(
      connected: nearbyService.connected,
      isScanning: (state as NearbyInProgress).isScanning,
    );
  }
}
