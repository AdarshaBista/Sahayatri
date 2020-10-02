// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkpoint.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckpointAdapter extends TypeAdapter<Checkpoint> {
  @override
  final int typeId = 4;

  @override
  Checkpoint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Checkpoint(
      place: fields[0] as Place,
      dateTime: fields[2] as DateTime,
      description: fields[1] as String,
      day: fields[3] as int,
      notifyContact: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Checkpoint obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.place)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.day)
      ..writeByte(4)
      ..write(obj.notifyContact);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckpointAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
