// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_layers.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MapLayersAdapter extends TypeAdapter<MapLayers> {
  @override
  final int typeId = 13;

  @override
  MapLayers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MapLayers(
      route: fields[0] as bool,
      flags: fields[1] as bool,
      places: fields[2] as bool,
      checkpoints: fields[3] as bool,
      nearbyDevices: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MapLayers obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.route)
      ..writeByte(1)
      ..write(obj.flags)
      ..writeByte(2)
      ..write(obj.places)
      ..writeByte(3)
      ..write(obj.checkpoints)
      ..writeByte(4)
      ..write(obj.nearbyDevices);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapLayersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
