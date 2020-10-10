import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/api_service.dart';

import 'package:sahayatri/app/database/destination_dao.dart';

class DestinationsService {
  final ApiService apiService;
  final DestinationDao destinationDao;

  /// Called when destination has finished downloading.
  void Function() onDownload;

  /// List of destiantions fetched from api.
  List<Destination> _destinations = [];
  List<Destination> get destinations => _destinations;

  /// List of destiantions downloaded on device.
  List<Destination> _downloaded = [];
  List<Destination> get downloaded => _downloaded;

  DestinationsService({
    @required this.apiService,
    @required this.destinationDao,
  })  : assert(apiService != null),
        assert(destinationDao != null);

  Future<void> fetchDestinations() async {
    try {
      _destinations = await apiService.fetchDestinations();
    } on AppError {
      rethrow;
    }
  }

  Future<void> fetchDownloaded() async {
    try {
      _downloaded = await destinationDao.getAll();
    } on AppError {
      rethrow;
    }
  }

  Future<void> download(Destination destination, User user) async {
    try {
      final fullDestination = await apiService.download(destination.id, user);
      fullDestination.isDownloaded = true;
      destination.places = fullDestination.places;
      destination.reviewsList = fullDestination.reviewsList;
      destination.isDownloaded = fullDestination.isDownloaded;
      destination.suggestedItineraries = fullDestination.suggestedItineraries;

      await destinationDao.upsert(fullDestination);
      _updateDownloaded(fullDestination);
      if (onDownload != null) onDownload();
    } on AppError {
      rethrow;
    }
  }

  void _updateDownloaded(Destination destination) {
    final downloadedIds = _downloaded.map((d) => d.id).toList();
    for (int i = 0; i < downloadedIds.length; ++i) {
      if (downloadedIds[i] == destination.id) _downloaded.removeAt(i);
    }
    _downloaded.add(destination);
  }

  Future<void> deleteDownloaded(String id) async {
    _downloaded.removeWhere((d) => d.id == id);
    await destinationDao.delete(id);
  }
}
