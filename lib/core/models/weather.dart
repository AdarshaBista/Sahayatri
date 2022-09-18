import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:hive/hive.dart';

part 'weather.g.dart';

@HiveType(typeId: 1)
class Weather {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final DateTime sunset;

  @HiveField(2)
  final DateTime sunrise;

  @HiveField(3)
  final int temp;

  @HiveField(4)
  final int minTemp;

  @HiveField(5)
  final int maxTemp;

  @HiveField(6)
  final int feelsLikeTemp;

  @HiveField(7)
  final int pressure;

  @HiveField(8)
  final int humidity;

  @HiveField(9)
  final double windSpeed;

  @HiveField(10)
  final String label;

  @HiveField(11)
  final String iconString;

  @HiveField(12)
  final DateTime createdAt;

  IconData get icon => _iconsMap[iconString] ?? Icons.error_outlined;

  Weather({
    required this.date,
    required this.sunset,
    required this.sunrise,
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.feelsLikeTemp,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.label,
    required this.iconString,
    required this.createdAt,
  });

  Weather copyWith({
    DateTime? date,
    DateTime? sunset,
    DateTime? sunrise,
    int? temp,
    int? minTemp,
    int? maxTemp,
    int? feelsLikeTemp,
    int? pressure,
    int? humidity,
    double? windSpeed,
    String? label,
    String? iconString,
    DateTime? createdAt,
  }) {
    return Weather(
      date: date ?? this.date,
      sunset: sunset ?? this.sunset,
      sunrise: sunrise ?? this.sunrise,
      temp: temp ?? this.temp,
      minTemp: minTemp ?? this.minTemp,
      maxTemp: maxTemp ?? this.maxTemp,
      feelsLikeTemp: feelsLikeTemp ?? this.feelsLikeTemp,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      label: label ?? this.label,
      iconString: iconString ?? this.iconString,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dt': date.millisecondsSinceEpoch ~/ 1000,
      'sunset': sunset.millisecondsSinceEpoch ~/ 1000,
      'sunrise': sunrise.millisecondsSinceEpoch ~/ 1000,
      'temp': {
        'day': temp,
        'min': minTemp,
        'max': maxTemp,
      },
      'feels_like': {
        'day': feelsLikeTemp,
      },
      'pressure': pressure,
      'humidity': humidity,
      'wind_speed': windSpeed,
      'weather': [
        {
          'main': label,
          'icon': iconString,
        },
      ],
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      date: DateTime.fromMillisecondsSinceEpoch((map['dt'] as int) * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch((map['sunset'] as int) * 1000),
      sunrise: DateTime.fromMillisecondsSinceEpoch((map['sunrise'] as int) * 1000),
      temp: (map['temp']['day'] as num).toInt(),
      minTemp: (map['temp']['min'] as num).toInt(),
      maxTemp: (map['temp']['max'] as num).toInt(),
      feelsLikeTemp: (map['feels_like']['day'] as num).toInt(),
      pressure: (map['pressure'] as num).toInt(),
      humidity: (map['humidity'] as num).toInt(),
      windSpeed: (map['wind_speed'] as num).toDouble(),
      label: map['weather'][0]['main'] as String,
      iconString: map['weather'][0]['icon'] as String,
      createdAt: map.containsKey('created_at')
          ? DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int)
          : DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'Weather(date: $date, sunset: $sunset, sunrise: $sunrise, temp: $temp, minTemp: $minTemp, maxTemp: $maxTemp, dayFeelsLikeTemp: $feelsLikeTemp, pressure: $pressure, humidity: $humidity, windSpeed: $windSpeed, label: $label, iconString: $iconString, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Weather &&
        other.date == date &&
        other.sunset == sunset &&
        other.sunrise == sunrise &&
        other.temp == temp &&
        other.minTemp == minTemp &&
        other.maxTemp == maxTemp &&
        other.feelsLikeTemp == feelsLikeTemp &&
        other.pressure == pressure &&
        other.humidity == humidity &&
        other.windSpeed == windSpeed &&
        other.label == label &&
        other.iconString == iconString &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        sunset.hashCode ^
        sunrise.hashCode ^
        temp.hashCode ^
        minTemp.hashCode ^
        maxTemp.hashCode ^
        feelsLikeTemp.hashCode ^
        pressure.hashCode ^
        humidity.hashCode ^
        windSpeed.hashCode ^
        label.hashCode ^
        iconString.hashCode ^
        createdAt.hashCode;
  }
}

const Map<String, IconData> _iconsMap = {
  '01d': CommunityMaterialIcons.weather_sunny,
  '01n': CommunityMaterialIcons.weather_night,
  '02d': CommunityMaterialIcons.weather_partly_cloudy,
  '02n': CommunityMaterialIcons.weather_night_partly_cloudy,
  '03d': CommunityMaterialIcons.weather_cloudy,
  '03n': CommunityMaterialIcons.weather_cloudy,
  '04d': CommunityMaterialIcons.weather_cloudy,
  '04n': CommunityMaterialIcons.weather_cloudy,
  '09d': CommunityMaterialIcons.weather_partly_rainy,
  '09n': CommunityMaterialIcons.weather_partly_rainy,
  '10d': CommunityMaterialIcons.weather_rainy,
  '10n': CommunityMaterialIcons.weather_rainy,
  '11d': CommunityMaterialIcons.weather_lightning_rainy,
  '11n': CommunityMaterialIcons.weather_lightning_rainy,
  '13d': CommunityMaterialIcons.weather_snowy,
  '13n': CommunityMaterialIcons.weather_snowy,
  '50d': CommunityMaterialIcons.weather_fog,
  '50n': CommunityMaterialIcons.weather_fog,
};
