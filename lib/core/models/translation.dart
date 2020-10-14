import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/language.dart';

class Translation {
  final bool isQuery;
  final bool isError;
  final String text;
  final Language language;

  Translation({
    this.isQuery = false,
    this.isError = false,
    @required this.text,
    @required this.language,
  })  : assert(text != null),
        assert(isQuery != null),
        assert(isError != null),
        assert(language != null);

  Translation copyWith({
    bool isQuery,
    bool isError,
    String text,
    Language language,
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
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Translation &&
        o.isQuery == isQuery &&
        o.isError == isError &&
        o.text == text &&
        o.language == language;
  }

  @override
  int get hashCode {
    return isQuery.hashCode ^ isError.hashCode ^ text.hashCode ^ language.hashCode;
  }
}
