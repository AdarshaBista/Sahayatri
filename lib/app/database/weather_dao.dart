import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/weather.dart';

class WeatherDao {
  static const String kWeatherBoxName = 'weather_box';

  final Future<Box<List>> _weatherBox = Hive.openBox(kWeatherBoxName);

  Future<List<Weather>> get(String key) async {
    final box = await _weatherBox;
    return box.get(key)?.cast<Weather>();
  }

  Future<void> upsert(String key, List<Weather> value) async {
    final box = await _weatherBox;
    box.put(key, value);
  }
}
