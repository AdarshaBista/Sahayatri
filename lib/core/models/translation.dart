import 'package:sahayatri/core/models/language.dart';

class Translation {
  final bool isQuery;
  final bool isError;
  final String text;
  final Language language;

  Translation({
    this.isQuery = false,
    this.isError = false,
    required this.text,
    required this.language,
  });

  Translation copyWith({
    bool? isQuery,
    bool? isError,
    String? text,
    Language? language,
  }) {
    return Translation(
      isQuery: isQuery ?? this.isQuery,
      isError: isError ?? this.isError,
      text: text ?? this.text,
      language: language ?? this.language,
    );
  }

  @override
  String toString() {
    return 'Translation(isQuery: $isQuery, isError: $isError, text: $text, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Translation &&
        other.isQuery == isQuery &&
        other.isError == isError &&
        other.text == text &&
        other.language == language;
  }

  @override
  int get hashCode {
    return isQuery.hashCode ^
        isError.hashCode ^
        text.hashCode ^
        language.hashCode;
  }
}
