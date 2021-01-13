import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/review_details.dart';
import 'package:sahayatri/core/models/lodge_facility.dart';

import 'package:sahayatri/core/utils/api_utils.dart';
import 'package:sahayatri/core/constants/hive_config.dart';

part 'lodge.g.dart';

@HiveType(typeId: HiveTypeIds.lodge)
class Lodge {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final Coord coord;

  @HiveField(3)
  final double rating;

  @HiveField(4)
  final LodgeFacility facility;

  @HiveField(5)
  final List<String> imageUrls;

  @HiveField(6)
  final List<String> contactNumbers;

  @HiveField(7)
  ReviewDetails reviewDetails;

  Lodge({
    @required this.id,
    @required this.name,
    @required this.coord,
    @required this.rating,
    @required this.facility,
    @required this.imageUrls,
    @required this.reviewDetails,
    @required this.contactNumbers,
  })  : assert(id != null),
        assert(name != null),
        assert(rating != null),
        assert(coord != null),
        assert(facility != null),
        assert(imageUrls != null),
        assert(reviewDetails != null),
        assert(contactNumbers != null);

  Lodge copyWith({
    String id,
    String name,
    Coord coord,
    double rating,
    LodgeFacility facility,
    List<String> imageUrls,
    ReviewDetails reviewDetails,
    List<String> contactNumbers,
  }) {
    return Lodge(
      id: id ?? this.id,
      name: name ?? this.name,
      coord: coord ?? this.coord,
      rating: rating ?? this.rating,
      facility: facility ?? this.facility,
      imageUrls: imageUrls ?? this.imageUrls,
      reviewDetails: reviewDetails ?? this.reviewDetails,
      contactNumbers: contactNumbers ?? this.contactNumbers,
    );
  }

  factory Lodge.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Lodge(
      id: map['id'] as String,
      name: map['name'] as String,
      rating:
          map['rating'] == null ? 0.0 : double.tryParse(map['rating'] as String) ?? 0.0,
      coord: Coord.fromCsv(map['coord'] as String),
      facility: LodgeFacility.parse(map['facility'] as String),
      imageUrls: ApiUtils.parseCsv(map['imageUrls'] as String),
      contactNumbers: ApiUtils.parseCsv(map['contactNumber'] as String),
      reviewDetails: !map.containsKey('reviews')
          ? const ReviewDetails()
          : ReviewDetails.fromMap(map['reviews'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return 'Lodge(id: $id, name: $name, coord: $coord, rating: $rating, contactNumbers: $contactNumbers, facility: $facility, imageUrls: $imageUrls, reviewDetails: $reviewDetails)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Lodge &&
        o.id == id &&
        o.name == name &&
        o.coord == coord &&
        o.rating == rating &&
        o.facility == facility &&
        o.reviewDetails == reviewDetails &&
        listEquals(o.imageUrls, imageUrls) &&
        listEquals(o.contactNumbers, contactNumbers);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        coord.hashCode ^
        rating.hashCode ^
        facility.hashCode ^
        imageUrls.hashCode ^
        reviewDetails.hashCode ^
        contactNumbers.hashCode;
  }
}
