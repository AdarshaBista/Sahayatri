import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/services/api_service.dart';

import 'package:sahayatri/app/database/destination_dao.dart';

import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  final ApiService apiService;
  final DestinationDao destinationDao;
  final DestinationCubit destinationCubit;

  DownloadCubit({
    @required this.apiService,
    @required this.destinationDao,
    @required this.destinationCubit,
  })  : assert(apiService != null),
        assert(destinationDao != null),
        assert(destinationCubit != null),
        super(const DownloadInitial());

  Future<void> startDownload(Destination destination) async {
    emit(DownloadInProgress(message: 'Downloading ${destination.name}'));
    await destinationDao.upsert(destination);
    destination.isDownloaded = true;
    destinationCubit.emit(destination);
    emit(const DownloadCompleted(message: 'Download complete!'));
  }

  void cancelDownload() {}
}
