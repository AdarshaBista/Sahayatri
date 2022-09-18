import 'package:hive/hive.dart';

import 'package:sahayatri/core/constants/hive_config.dart';
import 'package:sahayatri/core/models/user.dart';

// TODO: Replace with secure storage
class UserDao {
  static const int _userKey = 0;
  final Future<Box<User>> _userBox = Hive.openBox(HiveBoxNames.user);

  Future<User?> get() async {
    final box = await _userBox;
    return box.get(_userKey);
  }

  Future<void> upsert(User user) async {
    final box = await _userBox;
    box.put(_userKey, user);
  }

  Future<void> delete() async {
    final box = await _userBox;
    await box.clear();
  }
}
