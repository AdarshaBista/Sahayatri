import 'package:meta/meta.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final String accessToken;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.imageUrl,
    this.accessToken = '',
  })  : assert(id != null),
        assert(name != null),
        assert(email != null),
        assert(imageUrl != null),
        assert(accessToken != null);

  User copyWith({
    String id,
    String name,
    String email,
    String imageUrl,
    String accessToken,
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
    if (map == null) return null;

    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String,
      accessToken: map['accessToken'] as String,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, imageUrl: $imageUrl, accessToken: $accessToken)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.id == id &&
        o.name == name &&
        o.email == email &&
        o.imageUrl == imageUrl &&
        o.accessToken == accessToken;
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
