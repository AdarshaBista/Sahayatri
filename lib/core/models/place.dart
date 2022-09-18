import 'package:hive/hive.dart';

import 'package:sahayatri/core/constants/hive_config.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/utils/api_utils.dart';

part 'place.g.dart';

@HiveType(typeId: HiveTypeIds.place)
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
    required this.id,
    required this.name,
    required this.coord,
    required this.imageUrls,
    required this.description,
    required this.isNetworkAvailable,
    required this.lodges,
  });

  Place copyWith({
    String? id,
    String? name,
    Coord? coord,
    String? description,
    bool? isNetworkAvailable,
    List<String>? imageUrls,
    List<Lodge>? lodges,
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
    return Place(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      coord: Coord.fromCsv(map['coord'] ?? ''),
      isNetworkAvailable: map['isNetworkAvailable'] ?? false,
      imageUrls: ApiUtils.parseCsv(map['imageUrls']),
      lodges: List<Lodge>.from((map['lodges']?.map((x) => Lodge.fromMap(x)))),
    );
  }

  @override
  String toString() {
    return 'Place(id: $id, name: $name, coord: $coord, description: $description, isNetworkAvailable: $isNetworkAvailable, imageUrls: $imageUrls, lodges: $lodges)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Place && other.id == id;
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
