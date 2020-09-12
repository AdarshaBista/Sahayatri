import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/destination_update.dart';

import 'package:sahayatri/core/services/api_service.dart';

part 'destination_update_state.dart';

class DestinationUpdateCubit extends Cubit<DestinationUpdateState> {
  final User user;
  final Destination destination;
  final ApiService apiService;

  DestinationUpdateCubit({
    @required this.user,
    @required this.apiService,
    @required this.destination,
  })  : assert(apiService != null),
        assert(destination != null),
        super(const DestinationUpdateEmpty());

  Future<void> fetchUpdates() async {
    if (destination.updates != null) {
      emit(DestinationUpdateLoaded(updates: destination.updates));
      return;
    }

    emit(const DestinationUpdateLoading());
    try {
      final updates = await apiService.fetchUpdates(destination.id);
      if (updates.isNotEmpty) {
        destination.updates = updates;
        emit(DestinationUpdateLoaded(updates: updates));
      } else {
        emit(const DestinationUpdateEmpty());
      }
    } on Failure catch (e) {
      emit(DestinationUpdateError(message: e.message));
    }
  }

  Future<bool> postUpdate(double rating, String text) async {
    if (user == null) return false;
    return false;
  }
}
