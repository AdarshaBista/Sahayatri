import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/review_details.dart';
import 'package:sahayatri/core/models/destination_update.dart';

import 'package:sahayatri/core/utils/api_utils.dart';
import 'package:sahayatri/core/constants/hive_config.dart';
import 'package:sahayatri/core/extensions/route_extension.dart';

part 'destination.g.dart';

@HiveType(typeId: HiveTypeIds.destination)
class Destination {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String permit;

  @HiveField(3)
  final String length;

  @HiveField(4)
  final double rating;

  @HiveField(5)
  final String description;

  @HiveField(6)
  final String maxAltitude;

  @HiveField(7)
  final String estimatedDuration;

  @HiveField(8)
  final List<Coord> route;

  @HiveField(9)
  final List<String> imageUrls;

  @HiveField(10)
  final List<String> bestMonths;

  @HiveField(11)
  List<Place>? places;

  @HiveField(12)
  ReviewDetails reviewDetails;

  @HiveField(13)
  List<Itinerary>? suggestedItineraries;

  @HiveField(14)
  List<DestinationUpdate>? updates;

  double get minLat => route.minLat;
  double get maxLat => route.maxLat;
  double get minLong => route.minLng;
  double get maxLong => route.maxLng;
  Coord get midPointCoord => route[route.length ~/ 2];

  Destination({
    required this.id,
    required this.name,
    required this.permit,
    required this.length,
    required this.rating,
    required this.description,
    required this.maxAltitude,
    required this.estimatedDuration,
    required this.route,
    required this.imageUrls,
    required this.bestMonths,
    required this.places,
    required this.reviewDetails,
    required this.suggestedItineraries,
    required this.updates,
  });

  Destination copyWith({
    String? id,
    String? name,
    String? permit,
    String? length,
    double? rating,
    String? description,
    String? maxAltitude,
    String? estimatedDuration,
    List<Coord>? route,
    List<String>? imageUrls,
    List<String>? bestMonths,
    List<Place>? places,
    ReviewDetails? reviewDetails,
    List<Itinerary>? suggestedItineraries,
    List<DestinationUpdate>? updates,
  }) {
    return Destination(
      id: id ?? this.id,
      name: name ?? this.name,
      permit: permit ?? this.permit,
      length: length ?? this.length,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      maxAltitude: maxAltitude ?? this.maxAltitude,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      route: route ?? this.route,
      imageUrls: imageUrls ?? this.imageUrls,
      bestMonths: bestMonths ?? this.bestMonths,
      places: places ?? this.places,
      reviewDetails: reviewDetails ?? this.reviewDetails,
      suggestedItineraries: suggestedItineraries ?? this.suggestedItineraries,
      updates: updates ?? this.updates,
    );
  }

  factory Destination.fromMap(Map<String, dynamic> map) {
    final places = !map.containsKey('places')
        ? null
        : List<Place>.from(map['places']?.map((x) => Place.fromMap(x)));

    final updates = !map.containsKey('updates')
        ? null
        : List<DestinationUpdate>.from(
            map['updates']?.map((x) => DestinationUpdate.fromMap(x)));

    final reviewDetails = !map.containsKey('reviews')
        ? const ReviewDetails()
        : ReviewDetails.fromMap(map['reviews']);

    final suggestedItineraries = !map.containsKey('itinenaries')
        ? null
        : List<Itinerary>.from(
            map['itinenaries']?.map((x) => Itinerary.fromMap(x)));

    return Destination(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      permit: map['permit'] ?? '',
      length: map['length'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      description: map['description'] ?? '',
      maxAltitude: map['maxAltitude'] ?? '',
      estimatedDuration: map['estimatedDuration'] ?? '',
      route: ApiUtils.parseRoute(map['route'] as String),
      imageUrls: ApiUtils.parseCsv(map['imageUrls'] as String),
      bestMonths: ApiUtils.parseCsv(map['bestMonths'] as String),
      places: places,
      updates: updates,
      reviewDetails: reviewDetails,
      suggestedItineraries: suggestedItineraries,
    );
  }

  @override
  String toString() {
    return 'Destination(id: $id, name: $name, permit: $permit, length: $length, rating: $rating, description: $description, maxAltitude: $maxAltitude, estimatedDuration: $estimatedDuration, route: $route, imageUrls: $imageUrls, bestMonths: $bestMonths, places: $places, reviewDetails: $reviewDetails, suggestedItineraries: $suggestedItineraries, updates: $updates)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Destination &&
        other.id == id &&
        other.name == name &&
        other.permit == permit &&
        other.length == length &&
        other.rating == rating &&
        other.description == description &&
        other.maxAltitude == maxAltitude &&
        other.estimatedDuration == estimatedDuration &&
        other.reviewDetails == reviewDetails &&
        listEquals(other.route, route) &&
        listEquals(other.imageUrls, imageUrls) &&
        listEquals(other.bestMonths, bestMonths) &&
        listEquals(other.places, places) &&
        listEquals(other.suggestedItineraries, suggestedItineraries) &&
        listEquals(other.updates, updates);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        permit.hashCode ^
        length.hashCode ^
        rating.hashCode ^
        description.hashCode ^
        maxAltitude.hashCode ^
        estimatedDuration.hashCode ^
        route.hashCode ^
        imageUrls.hashCode ^
        bestMonths.hashCode ^
        places.hashCode ^
        updates.hashCode ^
        reviewDetails.hashCode ^
        suggestedItineraries.hashCode;
  }
}
