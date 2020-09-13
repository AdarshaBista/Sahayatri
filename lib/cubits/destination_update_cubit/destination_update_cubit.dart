import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/destination_update.dart';

import 'package:sahayatri/core/services/api_service.dart';

part 'destination_update_state.dart';

class DestinationUpdateCubit extends Cubit<DestinationUpdateState> {
  final User user;
  final ApiService apiService;
  final Destination destination;

  int page = 1;
  int total = 0;

  DestinationUpdateCubit({
    @required this.user,
    @required this.apiService,
    @required this.destination,
  })  : assert(apiService != null),
        assert(destination != null),
        super(const DestinationUpdateEmpty());

  bool get hasMore => destination.updates.length < total;

  Future<bool> loadMore() async {
    page++;
    try {
      final updatesList = await apiService.fetchUpdates(destination.id, page);
      final updates = updatesList.updates;
      destination.updates.addAll(updates);
      emit(DestinationUpdateLoaded(updates: destination.updates));
      return true;
    } on Failure {
      return false;
    }
  }

  Future<void> fetchUpdates() async {
    if (destination.updates != null) {
      emit(DestinationUpdateLoaded(updates: destination.updates));
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
    } on Failure catch (e) {
      emit(DestinationUpdateError(message: e.message));
    }
  }

  Future<bool> postUpdate(
    String text,
    List<Coord> coords,
    List<String> tags,
    List<String> imageUrls,
  ) async {
    if (user == null) return false;

    try {
      final id = await apiService.postUpdate(
          text, coords, tags, imageUrls, destination.id, user);
      final update = DestinationUpdate(
        id: id,
        text: text,
        user: user,
        tags: tags,
        coords: coords,
        imageUrls: imageUrls,
        dateUpdated: DateTime.now(),
      );

      destination.updates ??= [];
      destination.updates.add(update);
      emit(DestinationUpdateLoaded(updates: destination.updates));
      return true;
    } on Failure {
      return false;
    }
  }
}
