import 'package:flutter/foundation.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/utils/api_utils.dart';

class DestinationUpdate {
  final User? user;
  final String? id;
  final String text;
  final DateTime dateUpdated;
  final List<String> tags;
  final List<Coord> coords;
  final List<String> imageUrls;

  String get timeAgo => timeago.format(dateUpdated);

  const DestinationUpdate({
    required this.text,
    required this.dateUpdated,
    required this.imageUrls,
    this.id,
    this.user,
    this.tags = const [],
    this.coords = const [],
  });

  DestinationUpdate copyWith({
    String? id,
    String? text,
    User? user,
    DateTime? dateUpdated,
    List<String>? tags,
    List<Coord>? coords,
    List<String>? imageUrls,
  }) {
    return DestinationUpdate(
      id: id ?? this.id,
      text: text ?? this.text,
      user: user ?? this.user,
      dateUpdated: dateUpdated ?? this.dateUpdated,
      tags: tags ?? this.tags,
      coords: coords ?? this.coords,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }

  factory DestinationUpdate.fromMap(Map<String, dynamic> map) {
    return DestinationUpdate(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      user: User.fromMap(map['user']),
      tags: ApiUtils.parseCsv(map['tag'] as String),
      coords: ApiUtils.parseRoute(map['coord'] as String),
      imageUrls: ApiUtils.parseCsv(map['imageUrls'] as String),
      dateUpdated: DateTime.tryParse(map['dateupdated'] as String) ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  @override
  String toString() {
    return 'DestinationUpdate(id: $id, text: $text, user: $user, dateUpdated: $dateUpdated, tags: $tags, coords: $coords, imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DestinationUpdate &&
        other.id == id &&
        other.text == text &&
        other.user == user &&
        other.dateUpdated == dateUpdated &&
        listEquals(other.tags, tags) &&
        listEquals(other.coords, coords) &&
        listEquals(other.imageUrls, imageUrls);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        text.hashCode ^
        user.hashCode ^
        dateUpdated.hashCode ^
        tags.hashCode ^
        coords.hashCode ^
        imageUrls.hashCode;
  }
}

class DestinationUpdatesList {
  final int total;
  final List<DestinationUpdate> updates;

  DestinationUpdatesList({
    required this.total,
    required this.updates,
  });
}
