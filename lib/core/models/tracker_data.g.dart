// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracker_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrackerDataAdapter extends TypeAdapter<TrackerData> {
  @override
  final int typeId = 12;

  @override
  TrackerData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrackerData(
      destinationId: fields[0] as String?,
      elapsed: fields[1] as int,
      smsSentList: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TrackerData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.destinationId)
      ..writeByte(1)
      ..write(obj.elapsed)
      ..writeByte(2)
      ..write(obj.smsSentList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackerDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
