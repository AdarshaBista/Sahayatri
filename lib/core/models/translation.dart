import 'package:meta/meta.dart';

class Translation {
  final String source;
  final String result;
  final String sourceLang;
  final String resultLang;

  Translation({
    @required this.source,
    @required this.result,
    @required this.sourceLang,
    @required this.resultLang,
  })  : assert(source != null),
        assert(sourceLang != null);

  Translation copyWith({
    String source,
    String result,
    String sourceLang,
    String resultLang,
  }) {
    return Translation(
      source: source ?? this.source,
      result: result ?? this.result,
      sourceLang: sourceLang ?? this.sourceLang,
      resultLang: resultLang ?? this.resultLang,
    );
  }

  @override
  String toString() {
    return 'Translation(source: $source, result: $result, sourceLang: $sourceLang, resultLang: $resultLang)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Translation &&
        o.source == source &&
        o.result == result &&
        o.sourceLang == sourceLang &&
        o.resultLang == resultLang;
  }

  @override
  int get hashCode {
    return source.hashCode ^ result.hashCode ^ sourceLang.hashCode ^ resultLang.hashCode;
  }
}
