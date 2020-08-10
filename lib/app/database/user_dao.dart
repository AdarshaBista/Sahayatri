import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/user.dart';

// TODO: Replace with secure storage
class UserDao {
  static const int kUserKey = 0;
  static const String kUserBoxName = 'user_box';

  final Future<Box<User>> _userBox = Hive.openBox(kUserBoxName);

  Future<User> get() async {
    final box = await _userBox;
    return box.get(kUserKey);
  }

  Future<void> save(User user) async {
    final box = await _userBox;
    box.put(kUserKey, user);
  }

  Future<void> remove(User user) async {
    final box = await _userBox;
    box.clear();
  }
}
