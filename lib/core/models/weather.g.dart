// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherAdapter extends TypeAdapter<Weather> {
  @override
  final int typeId = 1;

  @override
  Weather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weather(
      date: fields[0] as DateTime,
      sunset: fields[1] as DateTime,
      sunrise: fields[2] as DateTime,
      temp: fields[3] as int,
      minTemp: fields[4] as int,
      maxTemp: fields[5] as int,
      feelsLikeTemp: fields[6] as int,
      pressure: fields[7] as int,
      humidity: fields[8] as int,
      windSpeed: fields[9] as double,
      label: fields[10] as String,
      iconString: fields[11] as String,
      createdAt: fields[12] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Weather obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.sunset)
      ..writeByte(2)
      ..write(obj.sunrise)
      ..writeByte(3)
      ..write(obj.temp)
      ..writeByte(4)
      ..write(obj.minTemp)
      ..writeByte(5)
      ..write(obj.maxTemp)
      ..writeByte(6)
      ..write(obj.feelsLikeTemp)
      ..writeByte(7)
      ..write(obj.pressure)
      ..writeByte(8)
      ..write(obj.humidity)
      ..writeByte(9)
      ..write(obj.windSpeed)
      ..writeByte(10)
      ..write(obj.label)
      ..writeByte(11)
      ..write(obj.iconString)
      ..writeByte(12)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
