class FormValidators {
  static String required<T>(T value, [String message = 'This is a required field.']) {
    if (value == null) return message;
    if (value is String && value.isEmpty) return message;
    return null;
  }
}
