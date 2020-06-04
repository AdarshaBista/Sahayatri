import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/review.dart';
import 'package:sahayatri/core/models/itinerary.dart';

class Destination {
  final int id;
  final String name;
  final String description;
  final String displayImageUrl;
  final String permit;
  final String length;
  final String maxAltitude;
  final String estimatedDuration;
  final List<String> imageUrls;
  final List<String> bestMonths;
  final List<Place> places;
  final List<Review> reviews;
  final List<Coord> routePoints;
  final List<Itinerary> suggestedItineraries;
  Itinerary createdItinerary;
  bool isDownloaded;

  Place get startingPlace => places.first;
  Place get endingPlace => places.last;

  Coord get midPointCoord => routePoints[routePoints.length ~/ 2];
  double get minLat => routePoints.map((c) => c.lat).reduce(math.min);
  double get maxLat => routePoints.map((c) => c.lat).reduce(math.max);
  double get minLong => routePoints.map((c) => c.lng).reduce(math.min);
  double get maxLong => routePoints.map((c) => c.lng).reduce(math.max);
  double get rating =>
      (reviews.map((r) => r.rating).reduce((e, v) => e + v)) / reviews.length;

  Destination(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.displayImageUrl,
      @required this.permit,
      @required this.length,
      @required this.maxAltitude,
      @required this.estimatedDuration,
      @required this.imageUrls,
      @required this.bestMonths,
      @required this.places,
      @required this.reviews,
      @required this.routePoints,
      @required this.suggestedItineraries,
      @required this.createdItinerary,
      @required this.isDownloaded})
      : assert(id != null),
        assert(name != null),
        assert(description != null),
        assert(displayImageUrl != null),
        assert(permit != null),
        assert(length != null),
        assert(maxAltitude != null),
        assert(estimatedDuration != null),
        assert(imageUrls != null),
        assert(bestMonths != null),
        assert(places != null),
        assert(reviews != null),
        assert(routePoints != null),
        assert(suggestedItineraries != null),
        assert(isDownloaded != null);

  Destination copyWith({
    int id,
    String name,
    String description,
    String displayImageUrl,
    String permit,
    String length,
    String maxAltitude,
    String estimatedDuration,
    List<String> imageUrls,
    List<String> bestMonths,
    List<Place> places,
    List<Review> reviews,
    List<Coord> routePoints,
    List<Itinerary> suggestedItineraries,
    Itinerary createdItinerary,
    bool isDownloaded,
  }) {
    return Destination(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      displayImageUrl: displayImageUrl ?? this.displayImageUrl,
      permit: permit ?? this.permit,
      length: length ?? this.length,
      maxAltitude: maxAltitude ?? this.maxAltitude,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      imageUrls: imageUrls ?? this.imageUrls,
      bestMonths: bestMonths ?? this.bestMonths,
      places: places ?? this.places,
      reviews: reviews ?? this.reviews,
      routePoints: routePoints ?? this.routePoints,
      suggestedItineraries: suggestedItineraries ?? this.suggestedItineraries,
      createdItinerary: createdItinerary ?? this.createdItinerary,
      isDownloaded: isDownloaded ?? this.isDownloaded,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'displayImageUrl': displayImageUrl,
      'permit': permit,
      'length': length,
      'maxAltitude': maxAltitude,
      'estimatedDuration': estimatedDuration,
      'imageUrls': imageUrls,
      'bestMonths': bestMonths,
      'places': places?.map((x) => x?.toMap())?.toList(),
      'reviews': reviews?.map((x) => x?.toMap())?.toList(),
      'routePoints': routePoints?.map((x) => x?.toMap())?.toList(),
      'suggestedItineraries':
          suggestedItineraries?.map((x) => x?.toMap())?.toList(),
      'createdItinerary': createdItinerary?.toMap(),
      'isDownloaded': isDownloaded,
    };
  }

  static Destination fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Destination(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      displayImageUrl: map['displayImageUrl'],
      permit: map['permit'],
      length: map['length'],
      maxAltitude: map['maxAltitude'],
      estimatedDuration: map['estimatedDuration'],
      imageUrls: List<String>.from(map['imageUrls']),
      bestMonths: List<String>.from(map['bestMonths']),
      places: List<Place>.from(map['places']?.map((x) => Place.fromMap(x))),
      reviews: List<Review>.from(map['reviews']?.map((x) => Review.fromMap(x))),
      routePoints:
          List<Coord>.from(map['routePoints']?.map((x) => Coord.fromMap(x))),
      suggestedItineraries: List<Itinerary>.from(
          map['suggestedItineraries']?.map((x) => Itinerary.fromMap(x))),
      createdItinerary: Itinerary.fromMap(map['createdItinerary']),
      isDownloaded: map['isDownloaded'],
    );
  }

  String toJson() => json.encode(toMap());

  static Destination fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Destination(id: $id, name: $name, description: $description, displayImageUrl: $displayImageUrl, permit: $permit, length: $length, maxAltitude: $maxAltitude, estimatedDuration: $estimatedDuration, imageUrls: $imageUrls, bestMonths: $bestMonths, places: $places, reviews: $reviews, routePoints: $routePoints, suggestedItineraries: $suggestedItineraries, createdItinerary: $createdItinerary, isDownloaded: $isDownloaded)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Destination &&
        o.id == id &&
        o.name == name &&
        o.description == description &&
        o.displayImageUrl == displayImageUrl &&
        o.permit == permit &&
        o.length == length &&
        o.maxAltitude == maxAltitude &&
        o.estimatedDuration == estimatedDuration &&
        listEquals(o.imageUrls, imageUrls) &&
        listEquals(o.bestMonths, bestMonths) &&
        listEquals(o.places, places) &&
        listEquals(o.reviews, reviews) &&
        listEquals(o.routePoints, routePoints) &&
        listEquals(o.suggestedItineraries, suggestedItineraries) &&
        o.createdItinerary == createdItinerary &&
        o.isDownloaded == isDownloaded;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        displayImageUrl.hashCode ^
        permit.hashCode ^
        length.hashCode ^
        maxAltitude.hashCode ^
        estimatedDuration.hashCode ^
        imageUrls.hashCode ^
        bestMonths.hashCode ^
        places.hashCode ^
        reviews.hashCode ^
        routePoints.hashCode ^
        suggestedItineraries.hashCode ^
        createdItinerary.hashCode ^
        isDownloaded.hashCode;
  }
}
