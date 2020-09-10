// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lodge.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LodgeAdapter extends TypeAdapter<Lodge> {
  @override
  final int typeId = 7;

  @override
  Lodge read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lodge(
      id: fields[0] as String,
      name: fields[1] as String,
      coord: fields[2] as Coord,
      rating: fields[3] as double,
      facility: fields[4] as LodgeFacility,
      imageUrls: (fields[5] as List)?.cast<String>(),
      reviewsList: fields[7] as ReviewsList,
      contactNumbers: (fields[6] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Lodge obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.coord)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.facility)
      ..writeByte(5)
      ..write(obj.imageUrls)
      ..writeByte(6)
      ..write(obj.contactNumbers)
      ..writeByte(7)
      ..write(obj.reviewsList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LodgeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
