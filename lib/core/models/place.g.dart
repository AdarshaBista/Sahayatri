// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceAdapter extends TypeAdapter<Place> {
  @override
  final int typeId = 9;

  @override
  Place read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Place(
      id: fields[0] as String,
      name: fields[1] as String,
      coord: fields[2] as Coord,
      imageUrls: (fields[5] as List).cast<String>(),
      description: fields[3] as String,
      isNetworkAvailable: fields[4] as bool,
      lodges: (fields[6] as List).cast<Lodge>(),
    );
  }

  @override
  void write(BinaryWriter writer, Place obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.coord)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.isNetworkAvailable)
      ..writeByte(5)
      ..write(obj.imageUrls)
      ..writeByte(6)
      ..write(obj.lodges);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
