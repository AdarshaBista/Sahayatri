import 'dart:convert';

import 'package:flutter/services.dart';

abstract class ConfigReader {
  ConfigReader._();
  static Map<String, dynamic> _config = {};

  static Future<void> initialize() async {
    final configString = await rootBundle.loadString('config/app_config.json');
    _config = jsonDecode(configString) as Map<String, dynamic>;
  }

  static String get openWeatherMapKey => _config['openWeatherMapKey'] as String;
  static String get mapBoxAccessToken => _config['mapBoxAccessToken'] as String;
}
