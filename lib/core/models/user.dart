import 'package:hive/hive.dart';

import 'package:sahayatri/core/constants/hive_config.dart';

part 'user.g.dart';

@HiveType(typeId: HiveTypeIds.user)
class User {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final String accessToken;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.imageUrl = '',
    this.accessToken = '',
  });

  bool get hasImage => imageUrl.trim().isNotEmpty;

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? imageUrl,
    String? accessToken,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'accessToken': accessToken,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      accessToken: map['accessToken'] ?? '',
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, imageUrl: $imageUrl, accessToken: $accessToken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.imageUrl == imageUrl &&
        other.accessToken == accessToken;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        imageUrl.hashCode ^
        accessToken.hashCode;
  }
}
