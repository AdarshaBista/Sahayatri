import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/services/directions_service.dart';

import 'package:sahayatri/locator.dart';

part 'directions_state.dart';

class DirectionsCubit extends Cubit<DirectionsState> {
  final DirectionsService directionsService = locator();

  DirectionsCubit() : super(const DirectionsInitial());

  Future<void> startNavigation(Coord coord, String mode) async {
    emit(const DirectionsLoading());
    try {
      await directionsService.startNavigation(coord, mode);
    } on AppError catch (e) {
      print(e);
      emit(DirectionsError(message: e.message));
    }
    emit(const DirectionsInitial());
  }
}
