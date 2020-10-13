import 'package:meta/meta.dart';

class Translation {
  final bool isQuery;
  final String text;
  final String language;

  Translation({
    @required this.isQuery,
    @required this.text,
    this.language,
  })  : assert(text != null),
        assert(isQuery != null);

  Translation copyWith({
    bool isQuery,
    String text,
    String language,
  }) {
    return Translation(
      isQuery: isQuery ?? this.isQuery,
      text: text ?? this.text,
      language: language ?? this.language,
    );
  }

  @override
  String toString() => 'Translation(isQuery: $isQuery, text: $text, language: $language)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Translation &&
        o.isQuery == isQuery &&
        o.text == text &&
        o.language == language;
  }

  @override
  int get hashCode => isQuery.hashCode ^ text.hashCode ^ language.hashCode;
}
