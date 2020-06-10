part of 'prefs_bloc.dart';

class PrefsState extends Equatable {
  final Prefs prefs;

  const PrefsState({
    @required this.prefs,
  }) : assert(prefs != null);

  @override
  List<Object> get props => [prefs];
}
