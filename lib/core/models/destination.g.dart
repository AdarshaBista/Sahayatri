// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DestinationAdapter extends TypeAdapter<Destination> {
  @override
  final int typeId = 3;

  @override
  Destination read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Destination(
      id: fields[0] as String,
      name: fields[1] as String,
      permit: fields[2] as String,
      length: fields[3] as String,
      rating: fields[4] as double,
      description: fields[5] as String,
      maxAltitude: fields[6] as String,
      estimatedDuration: fields[7] as String,
      route: (fields[8] as List).cast<Coord>(),
      imageUrls: (fields[9] as List).cast<String>(),
      bestMonths: (fields[10] as List).cast<String>(),
      places: (fields[11] as List?)?.cast<Place>(),
      reviewDetails: fields[12] as ReviewDetails,
      suggestedItineraries: (fields[13] as List?)?.cast<Itinerary>(),
      updates: (fields[14] as List?)?.cast<DestinationUpdate>(),
    );
  }

  @override
  void write(BinaryWriter writer, Destination obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.permit)
      ..writeByte(3)
      ..write(obj.length)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.maxAltitude)
      ..writeByte(7)
      ..write(obj.estimatedDuration)
      ..writeByte(8)
      ..write(obj.route)
      ..writeByte(9)
      ..write(obj.imageUrls)
      ..writeByte(10)
      ..write(obj.bestMonths)
      ..writeByte(11)
      ..write(obj.places)
      ..writeByte(12)
      ..write(obj.reviewDetails)
      ..writeByte(13)
      ..write(obj.suggestedItineraries)
      ..writeByte(14)
      ..write(obj.updates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DestinationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
