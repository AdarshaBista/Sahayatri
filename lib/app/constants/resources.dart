class AppConfig {
  static const String kAppName = 'Sahayatri';
  static const String kFontFamily = 'Sen';
  static const String kFontFamilySerif = 'RobotoSlab';
  static const int kAnimatorDuration = 500;
}

class Images {
  static const String kSplash = 'assets/icon/splash.png';
  static const String kMarker = 'assets/images/indicators/marker.png';
  static const String kUserMarker = 'assets/images/indicators/user_marker.png';
  static const String kError = 'assets/images/indicators/error.png';
  static const String kEmpty = 'assets/images/indicators/empty.png';
  static const String kLoading = 'assets/images/indicators/loading.png';
  static const String kRequired = 'assets/images/indicators/required.png';
  static const String kDownloading = 'assets/images/indicators/downloading.png';
  static const String kLocationError = 'assets/images/indicators/location_error.png';
}

class MapStyles {
  static const String kDark = 'mapbox/dark-v10';
  static const String kLight = 'mapbox/light-v10';
  static const String kStreets = 'mapbox/streets-v11';
  static const String kOutdoors = 'mapbox/outdoors-v11';
  static const String kSatellite = 'mapbox/satellite-v9';
}

class NotificationChannels {
  static const String kOffRouteId = 'off_route';
  static const String kOffRouteName = 'Off Route Alert';
  static const String kOffRouteDesc = 'Notify when user goes off-route';
}

class Distances {
  static const double kMinNearbyDistance = 50.0;
  static const double kNextStopTolerance = 50.0;
}
