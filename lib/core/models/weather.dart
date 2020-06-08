import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';

class Weather {
  final DateTime date;
  final DateTime sunset;
  final DateTime sunrise;
  final double minTemp;
  final double maxTemp;
  final double dayTemp;
  final double nightTemp;
  final double dayFeelsLikeTemp;
  final double nightFeelsLikeTemp;
  final double pressure;
  final double humidity;
  final double windSpeed;
  final String label;
  final IconData icon;

  Weather({
    @required this.date,
    @required this.sunset,
    @required this.sunrise,
    @required this.minTemp,
    @required this.maxTemp,
    @required this.dayTemp,
    @required this.nightTemp,
    @required this.dayFeelsLikeTemp,
    @required this.nightFeelsLikeTemp,
    @required this.pressure,
    @required this.humidity,
    @required this.windSpeed,
    @required this.label,
    @required this.icon,
  })  : assert(date != null),
        assert(sunset != null),
        assert(sunrise != null),
        assert(minTemp != null),
        assert(maxTemp != null),
        assert(dayTemp != null),
        assert(nightTemp != null),
        assert(dayFeelsLikeTemp != null),
        assert(nightFeelsLikeTemp != null),
        assert(pressure != null),
        assert(humidity != null),
        assert(windSpeed != null),
        assert(label != null),
        assert(icon != null);

  Weather copyWith({
    DateTime date,
    DateTime sunset,
    DateTime sunrise,
    double minTemp,
    double maxTemp,
    double dayTemp,
    double nightTemp,
    double dayFeelsLikeTemp,
    double nightFeelsLikeTemp,
    double pressure,
    double humidity,
    double windSpeed,
    String label,
    IconData icon,
  }) {
    return Weather(
      date: date ?? this.date,
      sunset: sunset ?? this.sunset,
      sunrise: sunrise ?? this.sunrise,
      minTemp: minTemp ?? this.minTemp,
      maxTemp: maxTemp ?? this.maxTemp,
      dayTemp: dayTemp ?? this.dayTemp,
      nightTemp: nightTemp ?? this.nightTemp,
      dayFeelsLikeTemp: dayFeelsLikeTemp ?? this.dayFeelsLikeTemp,
      nightFeelsLikeTemp: nightFeelsLikeTemp ?? this.nightFeelsLikeTemp,
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
      'minTemp': minTemp,
      'maxTemp': maxTemp,
      'dayTemp': dayTemp,
      'nightTemp': nightTemp,
      'dayFeelsLikeTemp': dayFeelsLikeTemp,
      'nightFeelsLikeTemp': nightFeelsLikeTemp,
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
      date: DateTime.fromMillisecondsSinceEpoch(map['dt'] as int),
      sunset: DateTime.fromMillisecondsSinceEpoch(map['sunset'] as int),
      sunrise: DateTime.fromMillisecondsSinceEpoch(map['sunrise'] as int),
      minTemp: map['minTemp'] as double,
      maxTemp: map['maxTemp'] as double,
      dayTemp: map['dayTemp'] as double,
      nightTemp: map['nightTemp'] as double,
      dayFeelsLikeTemp: map['dayFeelsLikeTemp'] as double,
      nightFeelsLikeTemp: map['nightFeelsLikeTemp'] as double,
      pressure: map['pressure'] as double,
      humidity: map['humidity'] as double,
      windSpeed: map['windSpeed'] as double,
      label: map['label'] as String,
      icon: _getIconData(map['icon'] as String),
    );
  }

  @override
  String toString() {
    return 'Weather(date: $date, sunset: $sunset, sunrise: $sunrise, minTemp: $minTemp, maxTemp: $maxTemp, dayTemp: $dayTemp, nightTemp: $nightTemp, dayFeelsLikeTemp: $dayFeelsLikeTemp, nightFeelsLikeTemp: $nightFeelsLikeTemp, pressure: $pressure, humidity: $humidity, windSpeed: $windSpeed, label: $label, icon: $icon)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Weather &&
        o.date == date &&
        o.sunset == sunset &&
        o.sunrise == sunrise &&
        o.minTemp == minTemp &&
        o.maxTemp == maxTemp &&
        o.dayTemp == dayTemp &&
        o.nightTemp == nightTemp &&
        o.dayFeelsLikeTemp == dayFeelsLikeTemp &&
        o.nightFeelsLikeTemp == nightFeelsLikeTemp &&
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
        minTemp.hashCode ^
        maxTemp.hashCode ^
        dayTemp.hashCode ^
        nightTemp.hashCode ^
        dayFeelsLikeTemp.hashCode ^
        nightFeelsLikeTemp.hashCode ^
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
