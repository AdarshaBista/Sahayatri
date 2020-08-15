import 'package:flutter/foundation.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/review.dart';
import 'package:sahayatri/core/models/itinerary.dart';

import 'package:sahayatri/core/utils/api_utils.dart';
import 'package:sahayatri/core/extensions/coord_list_x.dart';

class Destination {
  final String id;
  final String name;
  final String permit;
  final String length;
  final double rating;
  final String description;
  final String maxAltitude;
  final String estimatedDuration;
  final List<Coord> route;
  final List<String> imageUrls;
  final List<String> bestMonths;
  bool isDownloaded;
  Itinerary createdItinerary;
  final List<Place> places;
  final List<Review> reviews;
  final List<Itinerary> suggestedItineraries;

  double get minLat => route.minLat;
  double get maxLat => route.maxLat;
  double get minLong => route.minLong;
  double get maxLong => route.maxLong;
  Coord get midPointCoord => route[route.length ~/ 2];

  Destination({
    @required this.id,
    @required this.name,
    @required this.permit,
    @required this.length,
    @required this.rating,
    @required this.description,
    @required this.maxAltitude,
    @required this.estimatedDuration,
    @required this.imageUrls,
    @required this.bestMonths,
    @required this.places,
    @required this.reviews,
    @required this.route,
    @required this.suggestedItineraries,
    @required this.createdItinerary,
    @required this.isDownloaded,
  })  : assert(id != null),
        assert(name != null),
        assert(permit != null),
        assert(length != null),
        assert(rating != null),
        assert(route != null),
        assert(imageUrls != null),
        assert(bestMonths != null),
        assert(description != null),
        assert(maxAltitude != null),
        assert(isDownloaded != null),
        assert(estimatedDuration != null);

  Destination copyWith({
    String id,
    String name,
    String permit,
    String length,
    double rating,
    String description,
    String maxAltitude,
    String estimatedDuration,
    List<Coord> route,
    List<String> imageUrls,
    List<String> bestMonths,
    bool isDownloaded,
    Itinerary createdItinerary,
    List<Place> places,
    List<Review> reviews,
    List<Itinerary> suggestedItineraries,
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
      isDownloaded: isDownloaded ?? this.isDownloaded,
      createdItinerary: createdItinerary ?? this.createdItinerary,
      places: places ?? this.places,
      reviews: reviews ?? this.reviews,
      suggestedItineraries: suggestedItineraries ?? this.suggestedItineraries,
    );
  }

  factory Destination.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Destination(
      id: map['id'] as String,
      name: map['name'] as String,
      length: map['length'] as String,
      permit: map['permits'] as String,
      description: map['description'] as String,
      maxAltitude: map['maxAltitude'] as String,
      estimatedDuration: map['estimatedDuration'] as String,
      rating: double.tryParse(map['rating'] as String) ?? 0.0,
      route: ApiUtils.parseRoute(map['route'] as String),
      imageUrls: ApiUtils.parseCsv(map['imageUrls'] as String),
      bestMonths: ApiUtils.parseCsv(map['bestMonths'] as String),
      isDownloaded: false,
      createdItinerary: null,
      places: null,
      reviews: null,
      suggestedItineraries: null,
    );
  }

  @override
  String toString() {
    return 'Destination(id: $id, name: $name, permit: $permit, length: $length, rating: $rating, description: $description, maxAltitude: $maxAltitude, estimatedDuration: $estimatedDuration, route: $route, imageUrls: $imageUrls, bestMonths: $bestMonths, isDownloaded: $isDownloaded, createdItinerary: $createdItinerary, places: $places, reviews: $reviews, suggestedItineraries: $suggestedItineraries)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Destination &&
        o.id == id &&
        o.name == name &&
        o.permit == permit &&
        o.length == length &&
        o.rating == rating &&
        o.description == description &&
        o.maxAltitude == maxAltitude &&
        o.estimatedDuration == estimatedDuration &&
        listEquals(o.route, route) &&
        listEquals(o.imageUrls, imageUrls) &&
        listEquals(o.bestMonths, bestMonths) &&
        o.isDownloaded == isDownloaded &&
        o.createdItinerary == createdItinerary &&
        listEquals(o.places, places) &&
        listEquals(o.reviews, reviews) &&
        listEquals(o.suggestedItineraries, suggestedItineraries);
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
        isDownloaded.hashCode ^
        createdItinerary.hashCode ^
        places.hashCode ^
        reviews.hashCode ^
        suggestedItineraries.hashCode;
  }
}
