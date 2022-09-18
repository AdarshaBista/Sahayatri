class Language {
  final String code;
  final String title;
  final String ttsCode;

  const Language({
    required this.code,
    required this.title,
    required this.ttsCode,
  });

  Language copyWith({
    String? code,
    String? title,
    String? ttsCode,
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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Language &&
        other.code == code &&
        other.title == title &&
        other.ttsCode == ttsCode;
  }

  @override
  int get hashCode => code.hashCode ^ title.hashCode ^ ttsCode.hashCode;
}
