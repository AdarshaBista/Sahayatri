import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/destinations_service.dart';

part 'destinations_state.dart';

class DestinationsCubit extends Cubit<DestinationsState> {
  final DestinationsService destinationsService = locator();

  DestinationsCubit() : super(const DestinationsEmpty());

  Future<void> fetchDestinations() async {
    emit(const DestinationsLoading());
    try {
      await destinationsService.fetchDestinations();
      if (destinationsService.destinations.isEmpty) {
        emit(const DestinationsEmpty());
      } else {
        emit(DestinationsLoaded(
          destinations: destinationsService.destinations,
        ));
      }
    } on AppError catch (e) {
      emit(DestinationsError(message: e.message));
    }
  }

  Future<void> search(String query) async {
    final destinations = destinationsService.destinations;

    if (query.isEmpty) {
      emit(DestinationsLoaded(destinations: destinations));
      return;
    }

    emit(const DestinationsLoading());
    final searchedDestinations = destinations
        .where(
          (d) => d.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    if (searchedDestinations.isEmpty) {
      emit(const DestinationsLoaded(isSearching: true, destinations: []));
    } else {
      emit(DestinationsLoaded(
        isSearching: true,
        destinations: searchedDestinations,
      ));
    }
  }
}
