// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lodge_facility.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LodgeFacilityAdapter extends TypeAdapter<LodgeFacility> {
  @override
  final int typeId = 8;

  @override
  LodgeFacility read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LodgeFacility(
      wifi: fields[0] as bool,
      toilet: fields[1] as bool,
      shower: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LodgeFacility obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.wifi)
      ..writeByte(1)
      ..write(obj.toilet)
      ..writeByte(2)
      ..write(obj.shower);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LodgeFacilityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
