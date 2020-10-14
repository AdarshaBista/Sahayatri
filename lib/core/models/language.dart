import 'package:meta/meta.dart';

class Language {
  final String code;
  final String title;

  const Language({
    @required this.code,
    @required this.title,
  })  : assert(code != null),
        assert(title != null);

  Language copyWith({
    String code,
    String title,
  }) {
    return Language(
      code: code ?? this.code,
      title: title ?? this.title,
    );
  }

  @override
  String toString() => 'Language(code: $code, title: $title)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Language && o.code == code && o.title == title;
  }

  @override
  int get hashCode => code.hashCode ^ title.hashCode;
}
