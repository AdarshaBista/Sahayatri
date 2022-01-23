part of 'translate_cubit.dart';

class TranslateState {
  bool isLoading;
  final List<Translation> translations;

  TranslateState({
    this.translations = const [],
    this.isLoading = false,
  });
}
