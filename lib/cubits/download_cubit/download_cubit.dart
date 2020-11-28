import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/destinations_service.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  final User user;
  final Destination destination;
  final DestinationsService destinationsService;

  DownloadCubit({
    @required this.user,
    @required this.destination,
    @required this.destinationsService,
  })  : assert(user != null),
        assert(destination != null),
        assert(destinationsService != null),
        super(const DownloadInitial());

  void checkDownloaded() {
    if (destination.isDownloaded) {
      emit(const DownloadCompleted());
    }
  }

  Future<void> startDownload() async {
    emit(DownloadInProgress(message: 'Downloading ${destination.name}'));
    try {
      await destinationsService.download(destination, user);
      emit(const DownloadCompleted());
    } on AppError catch (e) {
      emit(DownloadError(message: e.message));
      emit(const DownloadInitial());
    }
  }
}
