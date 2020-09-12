import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/reviews_list.dart';
import 'package:sahayatri/core/models/destination_update.dart';

import 'package:sahayatri/core/utils/api_utils.dart';
import 'package:sahayatri/core/extensions/coord_list_x.dart';

import 'package:sahayatri/app/constants/hive_config.dart';

part 'destination.g.dart';

@HiveType(typeId: HiveTypeIds.kDestination)
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
  bool isDownloaded;

  @HiveField(12)
  Itinerary createdItinerary;

  @HiveField(13)
  List<Place> places;

  @HiveField(14)
  ReviewsList reviewsList;

  @HiveField(15)
  List<Itinerary> suggestedItineraries;

  @HiveField(16)
  List<DestinationUpdate> updates;

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
    @required this.route,
    @required this.imageUrls,
    @required this.bestMonths,
    @required this.places,
    @required this.updates,
    @required this.reviewsList,
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
        assert(reviewsList != null),
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
    ReviewsList reviewsList,
    List<DestinationUpdate> updates,
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
      updates: updates ?? this.updates,
      reviewsList: reviewsList ?? this.reviewsList,
      suggestedItineraries: suggestedItineraries ?? this.suggestedItineraries,
    );
  }

  factory Destination.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    final places = !map.containsKey('places')
        ? null
        : List<Place>.from((map['places'] as List<dynamic>)
            ?.map((x) => Place.fromMap(x as Map<String, dynamic>)));

    final updates = !map.containsKey('updates')
        ? null
        : List<DestinationUpdate>.from((map['updates'] as List<dynamic>)
            ?.map((x) => DestinationUpdate.fromMap(x as Map<String, dynamic>)));

    final reviewsList = !map.containsKey('reviews')
        ? const ReviewsList()
        : ReviewsList.fromMap(map['reviews'] as Map<String, dynamic>);

    final suggestedItineraries = !map.containsKey('itinenaries')
        ? null
        : List<Itinerary>.from((map['itinenaries'] as List<dynamic>)
            ?.map((x) => Itinerary.fromMap(x as Map<String, dynamic>)));

    return Destination(
      id: map['id'] as String,
      name: map['name'] as String,
      length: map['length'] as String,
      permit: map['permits'] as String,
      description: map['description'] as String,
      maxAltitude: map['maxAltitude'] as String,
      estimatedDuration: map['estimatedDuration'] as String,
      rating:
          map['rating'] == null ? 0.0 : double.tryParse(map['rating'] as String) ?? 0.0,
      route: ApiUtils.parseRoute(map['route'] as String),
      imageUrls: ApiUtils.parseCsv(map['imageUrls'] as String),
      bestMonths: ApiUtils.parseCsv(map['bestMonths'] as String),
      isDownloaded: false,
      createdItinerary: null,
      places: places,
      updates: updates,
      reviewsList: reviewsList,
      suggestedItineraries: suggestedItineraries,
    );
  }

  @override
  String toString() {
    return 'Destination(id: $id, name: $name, permit: $permit, length: $length, rating: $rating, description: $description, maxAltitude: $maxAltitude, estimatedDuration: $estimatedDuration, route: $route, imageUrls: $imageUrls, bestMonths: $bestMonths, isDownloaded: $isDownloaded, createdItinerary: $createdItinerary, places: $places, updates: $updates, reviewsList: $reviewsList, suggestedItineraries: $suggestedItineraries)';
  }

  @override
  bool operator ==(Object o) => false;

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
        updates.hashCode ^
        reviewsList.hashCode ^
        suggestedItineraries.hashCode;
  }
}
