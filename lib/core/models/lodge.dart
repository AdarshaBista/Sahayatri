import 'package:flutter/foundation.dart';

import 'package:sahayatri/core/models/coord.dart';

class Lodge {
  final int id;
  final String name;
  final Coord coord;
  final double rating;
  final String contactNumber;
  final List<String> imageUrls;

  const Lodge({
    @required this.id,
    @required this.name,
    @required this.coord,
    @required this.rating,
    @required this.contactNumber,
    @required this.imageUrls,
  })  : assert(id != null),
        assert(name != null),
        assert(contactNumber != null),
        assert(rating != null),
        assert(coord != null),
        assert(imageUrls != null);

  Lodge copyWith({
    int id,
    String name,
    Coord coord,
    double rating,
    String contactNumber,
    List<String> imageUrls,
  }) {
    return Lodge(
      id: id ?? this.id,
      name: name ?? this.name,
      coord: coord ?? this.coord,
      rating: rating ?? this.rating,
      contactNumber: contactNumber ?? this.contactNumber,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'coord': coord?.toMap(),
      'rating': rating,
      'contactNumber': contactNumber,
      'imageUrls': imageUrls,
    };
  }

  factory Lodge.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Lodge(
      id: map['id'] as int,
      name: map['name'] as String,
      coord: Coord.fromMap(map['coord'] as Map<String, dynamic>),
      rating: map['rating'] as double,
      contactNumber: map['contactNumber'] as String,
      imageUrls: List<String>.from(map['imageUrls'] as List<String>),
    );
  }

  @override
  String toString() {
    return 'Lodge(id: $id, name: $name, coord: $coord, rating: $rating, contactNumber: $contactNumber, imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Lodge &&
        o.id == id &&
        o.name == name &&
        o.coord == coord &&
        o.rating == rating &&
        o.contactNumber == contactNumber &&
        listEquals(o.imageUrls, imageUrls);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        coord.hashCode ^
        rating.hashCode ^
        contactNumber.hashCode ^
        imageUrls.hashCode;
  }
}
