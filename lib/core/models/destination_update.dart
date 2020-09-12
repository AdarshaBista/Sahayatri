import 'package:flutter/foundation.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/utils/api_utils.dart';

class DestinationUpdate {
  final String id;
  final String text;
  final User user;
  final Coord coord;
  final DateTime dateUpdated;
  final List<String> tags;
  final List<String> imageUrls;

  const DestinationUpdate({
    @required this.id,
    @required this.text,
    @required this.user,
    @required this.coord,
    @required this.dateUpdated,
    @required this.tags,
    @required this.imageUrls,
  })  : assert(id != null),
        assert(text != null),
        assert(user != null),
        assert(imageUrls != null),
        assert(dateUpdated != null);

  DestinationUpdate copyWith({
    String id,
    String text,
    User user,
    Coord coord,
    DateTime dateUpdated,
    List<String> tags,
    List<String> imageUrls,
  }) {
    return DestinationUpdate(
      id: id ?? this.id,
      text: text ?? this.text,
      tags: tags ?? this.tags,
      user: user ?? this.user,
      coord: coord ?? this.coord,
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
      coord: ApiUtils.parseCoord(map['coord'] as String),
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      imageUrls: ApiUtils.parseCsv(map['imageUrls'] as String),
      dateUpdated: DateTime.tryParse(map['dateupdated'] as String) ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  @override
  String toString() {
    return 'DestinationUpdate(id: $id, text: $text, user: $user, coord: $coord, dateUpdated: $dateUpdated, tags: $tags, imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DestinationUpdate &&
        o.id == id &&
        o.text == text &&
        o.user == user &&
        o.coord == coord &&
        o.dateUpdated == dateUpdated &&
        listEquals(o.tags, tags) &&
        listEquals(o.imageUrls, imageUrls);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        text.hashCode ^
        user.hashCode ^
        coord.hashCode ^
        dateUpdated.hashCode ^
        tags.hashCode ^
        imageUrls.hashCode;
  }
}
