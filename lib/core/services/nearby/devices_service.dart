import 'package:collection/collection.dart';
import 'package:sahayatri/core/models/nearby_device.dart';

class DevicesService {
  /// List of nearby devices.
  final Set<NearbyDevice> _devices = {};
  List<NearbyDevice> get devices => _devices.toList();

  /// Called when a device is added to or updated in [_devices].
  void Function()? onDeviceChanged;

  /// Clears current list of devices.
  void clear() => _devices.clear();

  /// Find [NearbyDevice] with given [id].
  NearbyDevice? findDevice(String id) {
    return _devices.firstWhereOrNull((d) => d.id == id);
  }

  /// Add a [NearbyDevice] to nearby devices set.
  void addDevice(String id, String name) {
    _devices.add(NearbyDevice(
      id: id,
      name: name,
      status: DeviceStatus.connecting,
    ));
    onDeviceChanged?.call();
  }

  /// Remove a [NearbyDevice] from nearby devices set.
  void removeDevice(NearbyDevice device) {
    _devices.remove(device);
  }

  /// Update [NearbyDevice] status to [status].
  void updateDeviceStatus(String id, DeviceStatus status) {
    final device = findDevice(id);
    if (device == null) return;
    device.status = status;
    onDeviceChanged?.call();
  }
}
