part of 'translate_cubit.dart';

abstract class TranslateState extends Equatable {
  const TranslateState();

  @override
  List<Object> get props => [];
}

class TranslateEmpty extends TranslateState {
  const TranslateEmpty();
}

class TranslateLoading extends TranslateState {
  const TranslateLoading();
}

class TranslateSuccess extends TranslateState {
  final Translation translation;

  const TranslateSuccess({
    @required this.translation,
  }) : assert(translation != null);

  @override
  List<Object> get props => [translation];
}

class TranslateError extends TranslateState {
  final String message;

  const TranslateError({
    @required this.message,
  }) : assert(message != null);

  @override
  List<Object> get props => [message];
}
