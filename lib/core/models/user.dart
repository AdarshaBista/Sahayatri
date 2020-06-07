import 'package:meta/meta.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String imageUrl;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.imageUrl,
  })  : assert(id != null),
        assert(name != null),
        assert(email != null),
        assert(imageUrl != null);

  User copyWith({
    int id,
    String name,
    String email,
    String imageUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.id == id &&
        o.name == name &&
        o.email == email &&
        o.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ imageUrl.hashCode;
  }
}
