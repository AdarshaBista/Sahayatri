import 'package:flutter/foundation.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/lodge_review.dart';
import 'package:sahayatri/core/models/lodge_facility.dart';

import 'package:sahayatri/core/utils/api_utils.dart';

class Lodge {
  final String id;
  final String name;
  final Coord coord;
  final double rating;
  final LodgeFacility facility;
  final List<String> imageUrls;
  final List<LodgeReview> reviews;
  final List<String> contactNumbers;

  const Lodge({
    @required this.id,
    @required this.name,
    @required this.coord,
    @required this.rating,
    @required this.reviews,
    @required this.facility,
    @required this.imageUrls,
    @required this.contactNumbers,
  })  : assert(id != null),
        assert(name != null),
        assert(rating != null),
        assert(coord != null),
        assert(facility != null),
        assert(imageUrls != null),
        assert(contactNumbers != null);

  Lodge copyWith({
    String id,
    String name,
    Coord coord,
    double rating,
    LodgeFacility facility,
    List<String> imageUrls,
    List<LodgeReview> reviews,
    List<String> contactNumbers,
  }) {
    return Lodge(
      id: id ?? this.id,
      name: name ?? this.name,
      coord: coord ?? this.coord,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      imageUrls: imageUrls ?? this.imageUrls,
      facility: facility ?? this.facility,
      contactNumbers: contactNumbers ?? this.contactNumbers,
    );
  }

  factory Lodge.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Lodge(
      id: map['id'] as String,
      name: map['name'] as String,
      rating: double.tryParse(map['rating'] as String) ?? 0.0,
      coord: ApiUtils.parseCoord(map['coord'] as String),
      facility: LodgeFacility.parse(map['facility'] as String),
      imageUrls: ApiUtils.parseCsv(map['imageUrls'] as String),
      contactNumbers: ApiUtils.parseCsv(map['contactNumber'] as String),
      reviews: null,
    );
  }

  @override
  String toString() {
    return 'Lodge(id: $id, name: $name, coord: $coord, rating: $rating, contactNumbers: $contactNumbers, facility: $facility, imageUrls: $imageUrls, reviews: $reviews)';
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
        listEquals(o.reviews, reviews) &&
        listEquals(o.imageUrls, imageUrls) &&
        listEquals(o.contactNumbers, contactNumbers);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        coord.hashCode ^
        rating.hashCode ^
        reviews.hashCode ^
        facility.hashCode ^
        imageUrls.hashCode ^
        contactNumbers.hashCode;
  }
}
