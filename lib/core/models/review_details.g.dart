// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewDetailsAdapter extends TypeAdapter<ReviewDetails> {
  @override
  final int typeId = 11;

  @override
  ReviewDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReviewDetails(
      total: fields[0] as int,
      stars: (fields[1] as Map).cast<int, int>(),
      reviews: (fields[2] as List).cast<Review>(),
    );
  }

  @override
  void write(BinaryWriter writer, ReviewDetails obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.total)
      ..writeByte(1)
      ..write(obj.stars)
      ..writeByte(2)
      ..write(obj.reviews);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
