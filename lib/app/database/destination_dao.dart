import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/constants/hive_config.dart';

class DestinationDao {
  final Future<Box<Destination>> _destinationBox;

  DestinationDao(String userId)
      : _destinationBox = Hive.openBox('$userId/${HiveBoxNames.destination}');

  Future<List<Destination>> getAll() async {
    final box = await _destinationBox;
    return box.values.toList();
  }

  Future<Destination> get(String id) async {
    final box = await _destinationBox;
    return box.get(id);
  }

  Future<void> upsert(Destination destination) async {
    final box = await _destinationBox;
    box.put(destination.id, destination);
  }

  Future<void> delete(String id) async {
    final box = await _destinationBox;
    box.delete(id);
  }

  Future<bool> contains(String id) async {
    final box = await _destinationBox;
    return box.containsKey(id);
  }
}
