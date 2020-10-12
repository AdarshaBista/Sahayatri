part of 'translate_cubit.dart';

class TranslateState {
  final List<Translation> translations;
  bool isLoading = false;

  TranslateState({
    this.translations = const [],
    this.isLoading = false,
  })  : assert(translations != null),
        assert(isLoading != null);

  TranslateState copyWith({
    List<Translation> translations,
    bool isLoading,
  }) {
    return TranslateState(
      translations: translations ?? this.translations,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
