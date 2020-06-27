// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prefs.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrefsAdapter extends TypeAdapter<Prefs> {
  @override
  final typeId = 0;

  @override
  Prefs read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Prefs(
      contact: fields[0] as String,
      mapStyle: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Prefs obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.contact)
      ..writeByte(1)
      ..write(obj.mapStyle);
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
