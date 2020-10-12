import 'package:meta/meta.dart';

class Translation {
  final String text;
  final String language;

  Translation({
    @required this.text,
    this.language,
  }) : assert(text != null);

  Translation copyWith({
    String text,
    String language,
  }) {
    return Translation(
      text: text ?? this.text,
      language: language ?? this.language,
    );
  }

  @override
  String toString() => 'Translation(text: $text, language: $language)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Translation && o.text == text && o.language == language;
  }

  @override
  int get hashCode => text.hashCode ^ language.hashCode;
}
