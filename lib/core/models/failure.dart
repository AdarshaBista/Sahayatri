import 'package:meta/meta.dart';

class Failure {
  final String error;
  final String message;

  const Failure({
    @required this.error,
    @required this.message,
  })  : assert(error != null),
        assert(message != null);
}
