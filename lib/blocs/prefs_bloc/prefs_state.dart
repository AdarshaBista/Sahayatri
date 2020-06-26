part of 'prefs_bloc.dart';

class PrefsState extends Equatable {
  const PrefsState();

  @override
  List<Object> get props => [];
}

class PrefsLoading extends PrefsState {}

class PrefsLoaded extends PrefsState {
  final Prefs prefs;

  const PrefsLoaded({
    @required this.prefs,
  }) : assert(prefs != null);

  @override
  List<Object> get props => [prefs];
}
