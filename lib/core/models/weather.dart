import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';

class Weather {
  final DateTime date;
  final DateTime sunset;
  final DateTime sunrise;
  final int temp;
  final int minTemp;
  final int maxTemp;
  final int feelsLikeTemp;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final String label;
  final String iconString;
  final DateTime createdAt;

  IconData get icon => _iconsMap[iconString];

  Weather({
    @required this.date,
    @required this.sunset,
    @required this.sunrise,
    @required this.temp,
    @required this.minTemp,
    @required this.maxTemp,
    @required this.feelsLikeTemp,
    @required this.pressure,
    @required this.humidity,
    @required this.windSpeed,
    @required this.label,
    @required this.iconString,
    @required this.createdAt,
  })  : assert(date != null),
        assert(sunset != null),
        assert(sunrise != null),
        assert(temp != null),
        assert(minTemp != null),
        assert(maxTemp != null),
        assert(feelsLikeTemp != null),
        assert(pressure != null),
        assert(humidity != null),
        assert(windSpeed != null),
        assert(label != null),
        assert(iconString != null),
        assert(createdAt != null);

  Weather copyWith({
    DateTime date,
    DateTime sunset,
    DateTime sunrise,
    int temp,
    int minTemp,
    int maxTemp,
    int feelsLikeTemp,
    int pressure,
    int humidity,
    double windSpeed,
    String label,
    String iconString,
    DateTime createdAt,
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
    if (map == null) return null;

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
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Weather &&
        o.date == date &&
        o.sunset == sunset &&
        o.sunrise == sunrise &&
        o.temp == temp &&
        o.minTemp == minTemp &&
        o.maxTemp == maxTemp &&
        o.feelsLikeTemp == feelsLikeTemp &&
        o.pressure == pressure &&
        o.humidity == humidity &&
        o.windSpeed == windSpeed &&
        o.label == label &&
        o.iconString == iconString &&
        o.createdAt == createdAt;
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
  '02d': CommunityMaterialIcons.weather_partlycloudy,
  '02n': CommunityMaterialIcons.weather_partlycloudy,
  '03d': CommunityMaterialIcons.weather_cloudy,
  '04d': CommunityMaterialIcons.weather_cloudy,
  '01n': CommunityMaterialIcons.weather_night,
  '03n': CommunityMaterialIcons.weather_night,
  '04n': CommunityMaterialIcons.weather_night,
  '09d': CommunityMaterialIcons.weather_rainy,
  '09n': CommunityMaterialIcons.weather_rainy,
  '10d': CommunityMaterialIcons.weather_rainy,
  '10n': CommunityMaterialIcons.weather_rainy,
  '11d': CommunityMaterialIcons.weather_lightning_rainy,
  '11n': CommunityMaterialIcons.weather_lightning_rainy,
  '13d': CommunityMaterialIcons.weather_snowy,
  '13n': CommunityMaterialIcons.weather_snowy,
  '50d': CommunityMaterialIcons.weather_fog,
  '50n': CommunityMaterialIcons.weather_fog,
};