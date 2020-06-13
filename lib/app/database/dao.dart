import 'package:meta/meta.dart';

import 'package:hive/hive.dart';

class Dao<T> {
  final Box<T> box;

  const Dao({
    @required this.box,
  }) : assert(box != null);

  T fetch(dynamic key, {T defaultValue}) {
    return box.get(key, defaultValue: defaultValue);
  }

  List<T> fetchAll() {
    return box.values.toList();
  }

  void store(dynamic key, T value) {
    box.put(key, value);
  }

  void delete(dynamic key) {
    box.delete(key);
  }
}
