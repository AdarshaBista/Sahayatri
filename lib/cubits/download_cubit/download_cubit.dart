import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/api_service.dart';

import 'package:sahayatri/app/database/destination_dao.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  final ApiService apiService;
  final DestinationDao destinationDao;

  DownloadCubit({
    @required this.apiService,
    @required this.destinationDao,
  })  : assert(apiService != null),
        assert(destinationDao != null),
        super(const DownloadInitial());

  Future<void> startDownload(Destination destination) async {
    destination.isDownloaded = true;

    emit(DownloadInProgress(message: 'Downloading ${destination.name}'));
    await destinationDao.upsert(destination);
    await Future.delayed(const Duration(seconds: 5));
    emit(const DownloadCompleted());
  }

  void stopDownload() {
    // TODO: Delete downloaded data
  }
}
