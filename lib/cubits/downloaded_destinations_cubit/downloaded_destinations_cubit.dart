import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/app/database/destination_dao.dart';

part 'downloaded_destinations_state.dart';

class DownloadedDestinationsCubit extends Cubit<DownloadedDestinationsState> {
  final DestinationDao destinationDao;

  DownloadedDestinationsCubit({
    @required this.destinationDao,
  })  : assert(destinationDao != null),
        super(const DownloadedDestinationsEmpty());

  Future<void> getDestinations() async {
    emit(const DownloadedDestinationsLoading());
    try {
      final destinations = await destinationDao.getAll();
      emit(DownloadedDestinationsLoaded(destinations: destinations));
    } on Failure catch (e) {
      emit(DownloadedDestinationsError(message: e.message));
    }
  }
}
