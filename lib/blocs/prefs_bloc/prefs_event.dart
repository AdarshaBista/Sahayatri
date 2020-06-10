part of 'prefs_bloc.dart';

abstract class PrefsEvent extends Equatable {
  const PrefsEvent();

  @override
  List<Object> get props => throw [];
}

class MapLayerChanged extends PrefsEvent {
  final MapLayer mapLayer;

  const MapLayerChanged({
    @required this.mapLayer,
  }) : assert(mapLayer != null);

  @override
  List<Object> get props => throw [mapLayer];
}
