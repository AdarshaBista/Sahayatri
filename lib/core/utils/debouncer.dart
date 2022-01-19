import 'dart:async';

class Debouncer {
  final int ms;
  Timer? _timer;

  Debouncer({this.ms = 400});

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: ms), action);
  }
}
