part of 'prefs_bloc.dart';

abstract class PrefsEvent extends Equatable {
  const PrefsEvent();

  @override
  List<Object> get props => [];
}

class PrefsInitialized extends PrefsEvent {
  const PrefsInitialized();
}

class MapLayerChanged extends PrefsEvent {
  final String mapStyle;

  const MapLayerChanged({
    @required this.mapStyle,
  }) : assert(mapStyle != null);

  @override
  List<Object> get props => [mapStyle];
}

class ContactSaved extends PrefsEvent {
  final String contact;

  const ContactSaved({
    @required this.contact,
  }) : assert(contact != null);

  @override
  List<Object> get props => [contact];
}
