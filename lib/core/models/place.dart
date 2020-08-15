import 'package:flutter/foundation.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/lodge.dart';

import 'package:sahayatri/core/utils/api_utils.dart';

class Place {
  final String id;
  final String name;
  final Coord coord;
  final String description;
  final bool isNetworkAvailable;
  final List<String> imageUrls;
  final List<Lodge> lodges;

  const Place({
    @required this.id,
    @required this.name,
    @required this.coord,
    @required this.imageUrls,
    @required this.description,
    @required this.isNetworkAvailable,
    @required this.lodges,
  })  : assert(id != null),
        assert(name != null),
        assert(coord != null),
        assert(description != null),
        assert(imageUrls != null),
        assert(isNetworkAvailable != null);

  Place copyWith({
    String id,
    String name,
    Coord coord,
    String description,
    bool isNetworkAvailable,
    List<String> imageUrls,
    List<Lodge> lodges,
  }) {
    return Place(
      id: id ?? this.id,
      name: name ?? this.name,
      coord: coord ?? this.coord,
      description: description ?? this.description,
      isNetworkAvailable: isNetworkAvailable ?? this.isNetworkAvailable,
      imageUrls: imageUrls ?? this.imageUrls,
      lodges: lodges ?? this.lodges,
    );
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Place(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      coord: ApiUtils.parseCoord(map['coord'] as String),
      isNetworkAvailable: map['isNetworkAvailable'] as bool,
      imageUrls: ApiUtils.parseCsv(map['imageUrls'] as String),
      lodges: null,
    );
  }

  @override
  String toString() {
    return 'Place(id: $id, name: $name, coord: $coord, description: $description, isNetworkAvailable: $isNetworkAvailable, imageUrls: $imageUrls, lodges: $lodges)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Place &&
        o.id == id &&
        o.name == name &&
        o.coord == coord &&
        o.description == description &&
        o.isNetworkAvailable == isNetworkAvailable &&
        listEquals(o.imageUrls, imageUrls) &&
        listEquals(o.lodges, lodges);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        coord.hashCode ^
        description.hashCode ^
        isNetworkAvailable.hashCode ^
        imageUrls.hashCode ^
        lodges.hashCode;
  }
}
