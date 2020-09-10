// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewsListAdapter extends TypeAdapter<ReviewsList> {
  @override
  final int typeId = 11;

  @override
  ReviewsList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReviewsList(
      total: fields[0] as int,
      stars: (fields[1] as Map)?.cast<int, int>(),
      reviews: (fields[2] as List)?.cast<Review>(),
    );
  }

  @override
  void write(BinaryWriter writer, ReviewsList obj) {
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
      other is ReviewsListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
