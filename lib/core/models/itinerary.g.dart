// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itinerary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItineraryAdapter extends TypeAdapter<Itinerary> {
  @override
  final int typeId = 6;

  @override
  Itinerary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Itinerary(
      name: fields[0] as String,
      days: fields[1] as String,
      nights: fields[2] as String,
      checkpoints: (fields[3] as List)?.cast<Checkpoint>(),
    );
  }

  @override
  void write(BinaryWriter writer, Itinerary obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.days)
      ..writeByte(2)
      ..write(obj.nights)
      ..writeByte(3)
      ..write(obj.checkpoints);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItineraryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
