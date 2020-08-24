import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/api_service.dart';

part 'destinations_state.dart';

class DestinationsCubit extends Cubit<DestinationsState> {
  final ApiService apiService;
  List<Destination> _destinations = [];

  DestinationsCubit({
    @required this.apiService,
  })  : assert(apiService != null),
        super(const DestinationsEmpty());

  Future<void> fetchDestinations() async {
    emit(const DestinationsLoading());
    try {
      _destinations = await apiService.fetchDestinations();
      emit(DestinationsLoaded(destinations: _destinations));
    } on Failure catch (e) {
      emit(DestinationsError(message: e.message));
    }
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      emit(DestinationsLoaded(destinations: _destinations));
      return;
    }

    emit(const DestinationsLoading());
    final searchedDestinations = _destinations
        .where(
          (d) => d.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    if (searchedDestinations.isEmpty) {
      emit(const DestinationsEmpty());
      return;
    }

    emit(DestinationsLoaded(destinations: searchedDestinations));
  }
}
