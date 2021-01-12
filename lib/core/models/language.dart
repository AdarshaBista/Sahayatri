import 'package:meta/meta.dart';

class Language {
  final String code;
  final String title;
  final String ttsCode;

  const Language({
    @required this.code,
    @required this.title,
    @required this.ttsCode,
  })  : assert(code != null),
        assert(title != null),
        assert(ttsCode != null);

  Language copyWith({
    String code,
    String title,
    String ttsCode,
  }) {
    return Language(
      code: code ?? this.code,
      title: title ?? this.title,
      ttsCode: ttsCode ?? this.ttsCode,
    );
  }

  @override
  String toString() => 'Language(code: $code, title: $title, ttsCode: $ttsCode)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Language && o.code == code && o.title == title && o.ttsCode == ttsCode;
  }

  @override
  int get hashCode => code.hashCode ^ title.hashCode ^ ttsCode.hashCode;
}
