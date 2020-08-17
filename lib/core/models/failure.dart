import 'package:meta/meta.dart';

class Failure {
  final String message;

  const Failure({
    @required this.message,
  }) : assert(message != null);

  @override
  String toString() => 'Failure(message: $message)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Failure && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
