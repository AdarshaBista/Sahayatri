import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/services/destinations_service.dart';

import 'package:sahayatri/locator.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  final User user;
  final Destination destination;
  final DestinationsService destinationsService = locator();

  DownloadCubit({
    required this.user,
    required this.destination,
  }) : super(const DownloadInitial());

  void checkDownloaded() {
    if (destinationsService.isDownloaded(destination)) {
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
