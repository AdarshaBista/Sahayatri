import 'package:meta/meta.dart';

class Failure {
  final String error;
  String message;

  Failure({
    @required this.error,
    this.message,
  }) : assert(error != null) {
    message ??= error;
  }
}
