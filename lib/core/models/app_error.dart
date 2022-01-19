class AppError {
  final String message;

  const AppError({
    required this.message,
  });

  @override
  String toString() => 'Failure(message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
