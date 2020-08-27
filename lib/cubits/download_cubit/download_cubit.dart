import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/destinations_service.dart';

import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  final User user;
  final DestinationCubit destinationCubit;
  final DestinationsService destinationsService;

  DownloadCubit({
    @required this.user,
    @required this.destinationCubit,
    @required this.destinationsService,
  })  : assert(user != null),
        assert(destinationCubit != null),
        assert(destinationsService != null),
        super(const DownloadInitial());

  Future<void> startDownload(Destination destination) async {
    emit(DownloadInProgress(message: 'Downloading ${destination.name}'));
    try {
      await destinationsService.download(destination, user);
      destinationCubit.emit(destination);
      emit(const DownloadCompleted(message: 'Download complete!'));
    } on Failure catch (e) {
      emit(DownloadCompleted(message: e.message));
    }
  }

  void cancelDownload() {}
}
