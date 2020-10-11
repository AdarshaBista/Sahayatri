import 'package:meta/meta.dart';

class Translation {
  final String text;
  final String source;
  final String sourceLang;
  final String targetLang;

  const Translation({
    @required this.text,
    @required this.source,
    @required this.sourceLang,
    @required this.targetLang,
  })  : assert(text != null),
        assert(source != null),
        assert(sourceLang != null),
        assert(targetLang != null);

  Translation copyWith({
    String text,
    String source,
    String sourceLang,
    String targetLang,
  }) {
    return Translation(
      text: text ?? this.text,
      source: source ?? this.source,
      sourceLang: sourceLang ?? this.sourceLang,
      targetLang: targetLang ?? this.targetLang,
    );
  }

  @override
  String toString() {
    return 'Translation(text: $text, source: $source, sourceLang: $sourceLang, targetLang: $targetLang)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Translation &&
        o.text == text &&
        o.source == source &&
        o.sourceLang == sourceLang &&
        o.targetLang == targetLang;
  }

  @override
  int get hashCode {
    return text.hashCode ^ source.hashCode ^ sourceLang.hashCode ^ targetLang.hashCode;
  }
}
