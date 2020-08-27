import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/destinations_service.dart';

part 'downloaded_destinations_state.dart';

class DownloadedDestinationsCubit extends Cubit<DownloadedDestinationsState> {
  final DestinationsService destinationsService;

  DownloadedDestinationsCubit({
    @required this.destinationsService,
  })  : assert(destinationsService != null),
        super(const DownloadedDestinationsEmpty());

  Future<void> fetchDownloaded() async {
    emit(const DownloadedDestinationsLoading());
    try {
      await destinationsService.fetchDownloaded();
      emit(DownloadedDestinationsLoaded(destinations: destinationsService.downloaded));
    } on Failure catch (e) {
      emit(DownloadedDestinationsError(message: e.message));
    }
  }

  Future<void> deleteDestination(Destination destination) async {
    await destinationsService.deleteDestination(destination);
    emit(DownloadedDestinationsMessage(message: 'Deleted ${destination.name}'));
    emit(DownloadedDestinationsLoaded(destinations: destinationsService.downloaded));
  }
}
