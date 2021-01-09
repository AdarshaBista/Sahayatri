import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/services/directions_service.dart';

part 'directions_state.dart';

class DirectionsCubit extends Cubit<DirectionsState> {
  final DirectionsService directionsService = locator();

  DirectionsCubit() : super(const DirectionsInitial());

  Future<void> startNavigation(Coord coord, String mode) async {
    emit(const DirectionsLoading());
    try {
      await directionsService.startNavigation(coord, mode);
    } on AppError catch (e) {
      emit(DirectionsError(message: e.message));
    }
    emit(const DirectionsInitial());
  }
}
