// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prefs.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrefsAdapter extends TypeAdapter<Prefs> {
  @override
  final int typeId = 0;

  @override
  Prefs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Prefs(
      contact: fields[0] as String,
      mapStyle: fields[1] as String,
      deviceName: fields[2] as String,
      isDarkTheme: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Prefs obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.contact)
      ..writeByte(1)
      ..write(obj.mapStyle)
      ..writeByte(2)
      ..write(obj.deviceName)
      ..writeByte(3)
      ..write(obj.isDarkTheme);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrefsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
