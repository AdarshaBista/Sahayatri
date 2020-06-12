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
  final IconData icon;

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
    @required this.icon,
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
        assert(icon != null);

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
    IconData icon,
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
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date?.millisecondsSinceEpoch,
      'sunset': sunset?.millisecondsSinceEpoch,
      'sunrise': sunrise?.millisecondsSinceEpoch,
      'dayTemp': temp,
      'minTemp': minTemp,
      'maxTemp': maxTemp,
      'dayFeelsLikeTemp': feelsLikeTemp,
      'pressure': pressure,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'label': label,
      'icon': icon?.codePoint,
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
      icon: _getIconData(map['weather'][0]['icon'] as String),
    );
  }

  @override
  String toString() {
    return 'Weather(date: $date, sunset: $sunset, sunrise: $sunrise, temp: $temp, minTemp: $minTemp, maxTemp: $maxTemp, dayFeelsLikeTemp: $feelsLikeTemp, pressure: $pressure, humidity: $humidity, windSpeed: $windSpeed, label: $label, icon: $icon)';
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
        o.icon == icon;
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
        icon.hashCode;
  }
}

IconData _getIconData(String iconCode) {
  switch (iconCode) {
    case '01d':
      return CommunityMaterialIcons.weather_sunny;
    case '02d':
    case '02n':
      return CommunityMaterialIcons.weather_partlycloudy;
    case '03d':
    case '04d':
      return CommunityMaterialIcons.weather_cloudy;
    case '01n':
    case '03n':
    case '04n':
      return CommunityMaterialIcons.weather_night;
    case '09d':
    case '09n':
    case '10d':
    case '10n':
      return CommunityMaterialIcons.weather_rainy;
    case '11d':
    case '11n':
      return CommunityMaterialIcons.weather_lightning_rainy;
    case '13d':
    case '13n':
      return CommunityMaterialIcons.weather_snowy;
    case '50d':
    case '50n':
      return CommunityMaterialIcons.weather_fog;
    default:
      return CommunityMaterialIcons.weather_sunny;
  }
}
