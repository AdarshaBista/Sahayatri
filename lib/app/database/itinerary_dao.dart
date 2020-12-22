import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/itinerary.dart';

import 'package:sahayatri/app/constants/hive_config.dart';

class ItineraryDao {
  final Future<Box<Itinerary>> _itineraryBox;

  ItineraryDao(String userId)
      : _itineraryBox = Hive.openBox('$userId/${HiveConfig.itineraryBoxName}');

  Future<Itinerary> get(String id) async {
    final box = await _itineraryBox;
    return box.get(id);
  }

  Future<void> upsert(String id, Itinerary itinerary) async {
    final box = await _itineraryBox;
    box.put(id, itinerary);
  }

  Future<void> delete(String id) async {
    final box = await _itineraryBox;
    box.delete(id);
  }
}
