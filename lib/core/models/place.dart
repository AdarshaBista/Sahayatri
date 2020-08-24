import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/lodge.dart';

import 'package:sahayatri/core/utils/api_utils.dart';

import 'package:sahayatri/app/constants/hive_config.dart';

part 'place.g.dart';

@HiveType(typeId: HiveTypeIds.kPlace)
class Place {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final Coord coord;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final bool isNetworkAvailable;

  @HiveField(5)
  final List<String> imageUrls;

  @HiveField(6)
  final List<Lodge> lodges;

  Place({
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
        assert(lodges != null),
        assert(imageUrls != null),
        assert(description != null),
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
      lodges: List<Lodge>.from((map['lodges'] as List<dynamic>)
          ?.map((x) => Lodge.fromMap(x as Map<String, dynamic>))),
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
