import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:sahayatri/core/constants/hive_config.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/lodge_facility.dart';
import 'package:sahayatri/core/models/review_details.dart';
import 'package:sahayatri/core/utils/api_utils.dart';

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
    required this.id,
    required this.name,
    required this.coord,
    required this.rating,
    required this.facility,
    required this.reviewDetails,
    this.imageUrls = const [],
    this.contactNumbers = const [],
  });

  Lodge copyWith({
    String? id,
    String? name,
    Coord? coord,
    double? rating,
    LodgeFacility? facility,
    List<String>? imageUrls,
    List<String>? contactNumbers,
    ReviewDetails? reviewDetails,
  }) {
    return Lodge(
      id: id ?? this.id,
      name: name ?? this.name,
      coord: coord ?? this.coord,
      rating: rating ?? this.rating,
      facility: facility ?? this.facility,
      imageUrls: imageUrls ?? this.imageUrls,
      contactNumbers: contactNumbers ?? this.contactNumbers,
      reviewDetails: reviewDetails ?? this.reviewDetails,
    );
  }

  factory Lodge.fromMap(Map<String, dynamic> map) {
    return Lodge(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      coord: Coord.fromMap(map['coord']),
      rating: map['rating']?.toDouble() ?? 0.0,
      facility: LodgeFacility.parse(map['facility']),
      imageUrls: ApiUtils.parseCsv(map['imageUrls']),
      contactNumbers: ApiUtils.parseCsv(map['contactNumber']),
      reviewDetails: !map.containsKey('reviews')
          ? const ReviewDetails()
          : ReviewDetails.fromMap(map['reviews'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return 'Lodge(id: $id, name: $name, coord: $coord, rating: $rating, facility: $facility, imageUrls: $imageUrls, contactNumbers: $contactNumbers, reviewDetails: $reviewDetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Lodge &&
        other.id == id &&
        other.name == name &&
        other.coord == coord &&
        other.rating == rating &&
        other.facility == facility &&
        listEquals(other.imageUrls, imageUrls) &&
        listEquals(other.contactNumbers, contactNumbers) &&
        other.reviewDetails == reviewDetails;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        coord.hashCode ^
        rating.hashCode ^
        facility.hashCode ^
        imageUrls.hashCode ^
        contactNumbers.hashCode ^
        reviewDetails.hashCode;
  }
}
