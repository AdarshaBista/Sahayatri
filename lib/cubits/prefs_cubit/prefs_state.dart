part of 'prefs_cubit.dart';

class PrefsState extends Equatable {
  const PrefsState();

  Prefs get value => (this as PrefsLoaded).prefs;

  @override
  List<Object> get props => [];
}

class PrefsLoading extends PrefsState {
  const PrefsLoading();
}

class PrefsLoaded extends PrefsState {
  final Prefs prefs;

  const PrefsLoaded({
    @required this.prefs,
  }) : assert(prefs != null);

  @override
  List<Object> get props => [prefs];
}
