class FormatUtils {
  /// Formats distance to 'x km' or 'x m.
  static String distance(double distance) {
    if (distance < 2000.0) return '${distance.toStringAsFixed(0)} m';

    final distanceInKm = (distance / 1000.0).toStringAsFixed(2);
    return '$distanceInKm km';
  }

  /// Formats [Duration] to 'HH:MM:SS'.
  static String time(Duration duration) {
    return [duration.inHours, duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }
}
