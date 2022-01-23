import 'package:bloc/bloc.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/destination_update.dart';

import 'package:sahayatri/core/services/api_service.dart';

part 'destination_update_state.dart';

class DestinationUpdateCubit extends Cubit<DestinationUpdateState> {
  final User? user;
  final Destination destination;
  final ApiService apiService = locator();

  int page = 1;
  int total = 0;

  DestinationUpdateCubit({
    this.user,
    required this.destination,
  }) : super(const DestinationUpdateEmpty());

  bool get hasMore => (destination.updates?.length ?? 0) < total;

  Future<bool> loadMore() async {
    page++;
    try {
      final updatesList = await apiService.fetchUpdates(destination.id, page);
      final updates = updatesList.updates;
      destination.updates?.addAll(updates);
      emit(DestinationUpdateLoaded(updates: destination.updates ?? []));
      return true;
    } on AppError {
      return false;
    }
  }

  Future<void> fetchUpdates() async {
    if (destination.updates != null) {
      emit(DestinationUpdateLoaded(updates: destination.updates ?? []));
      return;
    }

    emit(const DestinationUpdateLoading());
    try {
      final updatesList = await apiService.fetchUpdates(destination.id, 1);
      total = updatesList.total;
      final updates = updatesList.updates;

      if (updates.isNotEmpty) {
        destination.updates = updates;
        emit(DestinationUpdateLoaded(updates: updates));
      } else {
        emit(const DestinationUpdateEmpty());
      }
    } on AppError catch (e) {
      emit(DestinationUpdateError(message: e.message));
    }
  }
}
