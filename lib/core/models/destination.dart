import 'package:flutter/foundation.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/review.dart';
import 'package:sahayatri/core/models/itinerary.dart';

import 'package:sahayatri/core/extensions/coord_list_x.dart';

class Destination {
  final int id;
  final String name;
  final String description;
  final String permit;
  final String length;
  final String maxAltitude;
  final String estimatedDuration;
  final List<String> imageUrls;
  final List<String> bestMonths;
  final List<Place> places;
  final List<Review> reviews;
  final List<Coord> route;
  final List<Itinerary> suggestedItineraries;
  Itinerary createdItinerary;
  bool isDownloaded;

  Place get startingPlace => places.first;
  Place get endingPlace => places.last;

  Coord get midPointCoord => route[route.length ~/ 2];
  double get minLat => route.minLat;
  double get maxLat => route.maxLat;
  double get minLong => route.minLong;
  double get maxLong => route.maxLong;
  double get rating {
    if (reviews.isEmpty) return 0.0;
    return (reviews.map((r) => r.rating).reduce((e, v) => e + v)) / reviews.length;
  }

  Destination(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.permit,
      @required this.length,
      @required this.maxAltitude,
      @required this.estimatedDuration,
      @required this.imageUrls,
      @required this.bestMonths,
      @required this.places,
      @required this.reviews,
      @required this.route,
      @required this.suggestedItineraries,
      @required this.createdItinerary,
      @required this.isDownloaded})
      : assert(id != null),
        assert(name != null),
        assert(description != null),
        assert(permit != null),
        assert(length != null),
        assert(maxAltitude != null),
        assert(estimatedDuration != null),
        assert(imageUrls != null),
        assert(bestMonths != null),
        assert(places != null),
        assert(reviews != null),
        assert(route != null),
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
    List<Coord> route,
    List<Itinerary> suggestedItineraries,
    Itinerary createdItinerary,
    bool isDownloaded,
  }) {
    return Destination(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      permit: permit ?? this.permit,
      length: length ?? this.length,
      maxAltitude: maxAltitude ?? this.maxAltitude,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      imageUrls: imageUrls ?? this.imageUrls,
      bestMonths: bestMonths ?? this.bestMonths,
      places: places ?? this.places,
      reviews: reviews ?? this.reviews,
      route: route ?? this.route,
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
      'permit': permit,
      'length': length,
      'maxAltitude': maxAltitude,
      'estimatedDuration': estimatedDuration,
      'imageUrls': imageUrls,
      'bestMonths': bestMonths,
      'places': places?.map((x) => x?.toMap())?.toList(),
      'reviews': reviews?.map((x) => x?.toMap())?.toList(),
      'routePoints': route?.map((x) => x?.toMap())?.toList(),
      'suggestedItineraries': suggestedItineraries?.map((x) => x?.toMap())?.toList(),
      'createdItinerary': createdItinerary?.toMap(),
      'isDownloaded': isDownloaded,
    };
  }

  factory Destination.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Destination(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      permit: map['permit'] as String,
      length: map['length'] as String,
      maxAltitude: map['maxAltitude'] as String,
      estimatedDuration: map['estimatedDuration'] as String,
      imageUrls: List<String>.from(map['imageUrls'] as List<String>),
      bestMonths: List<String>.from(map['bestMonths'] as List<String>),
      places: List<Place>.from((map['places'] as List<Place>)
          ?.map((x) => Place.fromMap(x as Map<String, dynamic>))),
      reviews: List<Review>.from((map['reviews'] as List<Review>)
          ?.map((x) => Review.fromMap(x as Map<String, dynamic>))),
      route: List<Coord>.from((map['routePoints'] as List<Coord>)
          ?.map((x) => Coord.fromMap(x as Map<String, dynamic>))),
      suggestedItineraries: List<Itinerary>.from(
          (map['suggestedItineraries'] as List<Itinerary>)
              ?.map((x) => Itinerary.fromMap(x as Map<String, dynamic>))),
      createdItinerary:
          Itinerary.fromMap(map['createdItinerary'] as Map<String, dynamic>),
      isDownloaded: map['isDownloaded'] as bool,
    );
  }

  @override
  String toString() {
    return 'Destination(id: $id, name: $name, description: $description, permit: $permit, length: $length, maxAltitude: $maxAltitude, estimatedDuration: $estimatedDuration, imageUrls: $imageUrls, bestMonths: $bestMonths, places: $places, reviews: $reviews, routePoints: $route, suggestedItineraries: $suggestedItineraries, createdItinerary: $createdItinerary, isDownloaded: $isDownloaded)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Destination &&
        o.id == id &&
        o.name == name &&
        o.description == description &&
        o.permit == permit &&
        o.length == length &&
        o.maxAltitude == maxAltitude &&
        o.estimatedDuration == estimatedDuration &&
        listEquals(o.imageUrls, imageUrls) &&
        listEquals(o.bestMonths, bestMonths) &&
        listEquals(o.places, places) &&
        listEquals(o.reviews, reviews) &&
        listEquals(o.route, route) &&
        listEquals(o.suggestedItineraries, suggestedItineraries) &&
        o.createdItinerary == createdItinerary &&
        o.isDownloaded == isDownloaded;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        permit.hashCode ^
        length.hashCode ^
        maxAltitude.hashCode ^
        estimatedDuration.hashCode ^
        imageUrls.hashCode ^
        bestMonths.hashCode ^
        places.hashCode ^
        reviews.hashCode ^
        route.hashCode ^
        suggestedItineraries.hashCode ^
        createdItinerary.hashCode ^
        isDownloaded.hashCode;
  }
}
