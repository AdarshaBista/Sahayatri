import 'package:flutter/foundation.dart';

import 'package:timeago/timeago.dart' as timeago;

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user.dart';

import 'package:sahayatri/core/utils/api_utils.dart';

class DestinationUpdate {
  final String id;
  final String text;
  final User user;
  final DateTime dateUpdated;
  final List<String> tags;
  final List<Coord> coords;
  final List<String> imageUrls;

  String get timeAgo => timeago.format(dateUpdated);

  const DestinationUpdate({
    this.id,
    this.user,
    @required this.text,
    @required this.dateUpdated,
    @required this.tags,
    @required this.coords,
    @required this.imageUrls,
  })  : assert(text != null),
        assert(imageUrls != null),
        assert(dateUpdated != null);

  DestinationUpdate copyWith({
    String id,
    String text,
    User user,
    DateTime dateUpdated,
    List<String> tags,
    List<Coord> coords,
    List<String> imageUrls,
  }) {
    return DestinationUpdate(
      id: id ?? this.id,
      text: text ?? this.text,
      tags: tags ?? this.tags,
      user: user ?? this.user,
      coords: coords ?? this.coords,
      dateUpdated: dateUpdated ?? this.dateUpdated,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }

  factory DestinationUpdate.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DestinationUpdate(
      id: map['id'] as String,
      text: map['text'] as String,
      tags: ApiUtils.parseCsv(map['tag'] as String),
      coords: ApiUtils.parseRoute(map['coord'] as String),
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      imageUrls: ApiUtils.parseCsv(map['imageUrls'] as String),
      dateUpdated: DateTime.tryParse(map['dateupdated'] as String) ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  @override
  String toString() {
    return 'DestinationUpdate(id: $id, text: $text, user: $user, coords: $coords, dateUpdated: $dateUpdated, tags: $tags, imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DestinationUpdate &&
        o.id == id &&
        o.text == text &&
        o.user == user &&
        o.coords == coords &&
        o.dateUpdated == dateUpdated &&
        listEquals(o.tags, tags) &&
        listEquals(o.imageUrls, imageUrls);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        text.hashCode ^
        user.hashCode ^
        coords.hashCode ^
        dateUpdated.hashCode ^
        tags.hashCode ^
        imageUrls.hashCode;
  }
}

class DestinationUpdatesList {
  final int total;
  final List<DestinationUpdate> updates;

  DestinationUpdatesList({
    @required this.total,
    @required this.updates,
  })  : assert(total != null),
        assert(updates != null);
}
