import 'package:flutter/foundation.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/lodge.dart';

class Place {
  final int id;
  final String name;
  final String description;
  final Coord coord;
  final bool isNetworkAvailable;
  final List<Lodge> lodges;
  final List<String> imageUrls;

  const Place({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.coord,
    @required this.isNetworkAvailable,
    @required this.lodges,
    @required this.imageUrls,
  })  : assert(id != null),
        assert(name != null),
        assert(description != null),
        assert(coord != null),
        assert(isNetworkAvailable != null),
        assert(lodges != null),
        assert(imageUrls != null);

  Place copyWith({
    int id,
    String name,
    String description,
    Coord coord,
    bool isNetworkAvailable,
    List<Lodge> lodges,
    List<String> imageUrls,
  }) {
    return Place(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      coord: coord ?? this.coord,
      isNetworkAvailable: isNetworkAvailable ?? this.isNetworkAvailable,
      lodges: lodges ?? this.lodges,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'coord': coord?.toMap(),
      'isNetworkAvailable': isNetworkAvailable,
      'lodges': lodges?.map((x) => x?.toMap())?.toList(),
      'imageUrls': imageUrls,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Place(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      coord: Coord.fromMap(map['coord'] as Map<String, dynamic>),
      isNetworkAvailable: map['isNetworkAvailable'] as bool,
      lodges: List<Lodge>.from((map['lodges'] as List<Lodge>)
          ?.map((x) => Lodge.fromMap(x as Map<String, dynamic>))),
      imageUrls: List<String>.from(map['imageUrls'] as List<String>),
    );
  }

  @override
  String toString() {
    return 'Place(id: $id, name: $name, description: $description, coord: $coord, isNetworkAvailable: $isNetworkAvailable, lodges: $lodges, imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Place &&
        o.id == id &&
        o.name == name &&
        o.description == description &&
        o.coord == coord &&
        o.isNetworkAvailable == isNetworkAvailable &&
        listEquals(o.lodges, lodges) &&
        listEquals(o.imageUrls, imageUrls);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        coord.hashCode ^
        isNetworkAvailable.hashCode ^
        lodges.hashCode ^
        imageUrls.hashCode;
  }
}
