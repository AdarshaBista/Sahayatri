import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/app/constants/hive_config.dart';

class DestinationDao {
  Future<Box<Destination>> _destinationBox;

  void init(String userId) {
    _destinationBox = Hive.openBox('$userId/${HiveConfig.destinationBoxName}');
  }

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
