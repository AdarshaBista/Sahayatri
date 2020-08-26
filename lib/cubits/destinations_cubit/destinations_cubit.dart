import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/api_service.dart';

import 'package:sahayatri/app/database/destination_dao.dart';

part 'destinations_state.dart';

class DestinationsCubit extends Cubit<DestinationsState> {
  final ApiService apiService;
  final DestinationDao destinationDao;

  List<Destination> _destinations = [];

  DestinationsCubit({
    @required this.apiService,
    @required this.destinationDao,
  })  : assert(apiService != null),
        assert(destinationDao != null),
        super(const DestinationsEmpty());

  Future<void> fetchDestinations() async {
    emit(const DestinationsLoading());
    try {
      final destinations = await apiService.fetchDestinations();
      final downloadedIds = await destinationDao.getAllIds();

      _destinations = destinations.map((destination) {
        if (downloadedIds.contains(destination.id)) destination.isDownloaded = true;
        return destination;
      }).toList();

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
