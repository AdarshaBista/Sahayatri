import 'package:sahayatri/app/constants/mocks.dart';

import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';

class ApiService {
  Future<List<Destination>> fetchDestinations() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return mockDestinations;
    } catch (e) {
      throw Failure(
        error: e.toString(),
        message: 'Failed to get destinations.',
      );
    }
  }
}
