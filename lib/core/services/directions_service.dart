import 'package:url_launcher/url_launcher.dart';

import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/coord.dart';

class DirectionsService {
  Future<void> startNavigation(Coord coord, String mode) async {
    final parameters = [
      'destination=${coord.lat},${coord.lng}',
      'dir_action=navigate',
      'travelmode=$mode',
    ].join('&');

    final uri = Uri.parse('https://www.google.com/maps/dir/?api=1&$parameters');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw const AppError(message: 'Could not launch Google Maps!');
    }
  }
}
