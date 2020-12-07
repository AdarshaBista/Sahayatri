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
      destination.places = fullDestination.places;
      destination.reviewDetails = fullDestination.reviewDetails;
      destination.suggestedItineraries = fullDestination.suggestedItineraries;

      await destinationDao.upsert(fullDestination);
      _downloaded.add(fullDestination);
      onDownload?.call();
    } on AppError {
      rethrow;
    }
  }

  Future<void> deleteDownloaded(String id) async {
    destinationDao.delete(id);
    _downloaded.removeWhere((d) => d.id == id);
  }

  bool isDownloaded(Destination destination) {
    return _downloaded.contains(destination);
  }
}
