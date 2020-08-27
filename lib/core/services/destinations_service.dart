import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/api_service.dart';

import 'package:sahayatri/app/database/destination_dao.dart';

class DestinationsService {
  final ApiService apiService;
  final DestinationDao destinationDao;

  List<Destination> _destinations = [];
  List<Destination> get destinations => _destinations;

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
    } on Failure {
      rethrow;
    }
  }

  Future<void> fetchDownloaded() async {
    try {
      _downloaded = await destinationDao.getAll();
    } on Failure {
      rethrow;
    }
  }

  Future<void> deleteDestination(Destination destination) async {
    _downloaded.remove(destination);
    await destinationDao.delete(destination.id);
  }
}
