import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/app/constants/map_layers.dart';

import 'package:sahayatri/core/models/prefs.dart';
import 'package:sahayatri/core/models/map_layer.dart';

part 'prefs_event.dart';
part 'prefs_state.dart';

class PrefsBloc extends Bloc<PrefsEvent, PrefsState> {
  @override
  PrefsState get initialState => PrefsState(
        prefs: Prefs(
          mapLayer: kMapLayers[MapLayerType.outdoors],
        ),
      );

  @override
  Stream<PrefsState> mapEventToState(PrefsEvent event) async* {
    if (event is MapLayerChanged) {
      yield PrefsState(prefs: state.prefs.copyWith(mapLayer: event.mapLayer));
    }
  }
}
