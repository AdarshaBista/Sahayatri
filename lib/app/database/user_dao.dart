import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/user.dart';

import 'package:sahayatri/app/constants/hive_config.dart';

// TODO: Replace with secure storage
class UserDao {
  static const int kUserKey = 0;
  final Future<Box<User>> _userBox = Hive.openBox(HiveConfig.kUserBoxName);

  Future<User> get() async {
    final box = await _userBox;
    return box.get(kUserKey);
  }

  Future<void> upsert(User user) async {
    final box = await _userBox;
    box.put(kUserKey, user);
  }

  Future<void> delete(User user) async {
    final box = await _userBox;
    box.clear();
  }
}
