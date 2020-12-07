part of 'prefs_cubit.dart';

class PrefsState extends Equatable {
  final Prefs prefs;
  final bool isLoading;

  const PrefsState({
    this.isLoading = false,
    this.prefs = const Prefs(),
  })  : assert(prefs != null),
        assert(isLoading != null);

  @override
  List<Object> get props => [prefs, isLoading];
}
