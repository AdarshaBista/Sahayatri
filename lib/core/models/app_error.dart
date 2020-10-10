import 'package:meta/meta.dart';

class AppError {
  final String message;

  const AppError({
    @required this.message,
  }) : assert(message != null);

  @override
  String toString() => 'Failure(message: $message)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AppError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
