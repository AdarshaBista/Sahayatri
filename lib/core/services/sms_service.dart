import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:sahayatri/app/constants/resources.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/place.dart';

class SmsService {
  final List<int> _sentList = [];

  bool shouldSend(Coord userLocation, Place nextStop) {
    if (nextStop == null || _sentList.contains(nextStop?.id)) return false;

    final distance = SphericalUtil.computeDistanceBetween(
      LatLng(userLocation.lat, userLocation.lng),
      LatLng(nextStop.coord.lat, nextStop.coord.lng),
    );
    return distance < Distances.kMinNearbyDistance;
  }

  void send(int placeId) {
    _sentList.add(placeId);
    print('Sent');
  }
}
