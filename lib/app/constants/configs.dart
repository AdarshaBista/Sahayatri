class AppConfig {
  static const String kAppName = 'Sahayatri';
  static const String kPackageName = 'com.adrsh.sahayatri';
  static const String kFontFamily = 'Sen';
  static const String kFontFamilySerif = 'RobotoSlab';
  static const String kSmsMessagePrefix = 'I have safely reached';
  static const String kApiBaseUrl = 'https://sahayatriapi.herokuapp.com/api/v1';
  static const String kWeatherApiBaseUrl = 'https://api.openweathermap.org/data/2.5';
}

class UiConfig {
  static const int kAnimatorDuration = 500;
  static const double kTrackerPanelHeight = 90.0;
}

class Images {
  static const String kSplash = 'assets/icons/splash.png';
  static const String kAuthBackground = 'assets/images/backgrounds/auth.png';
  static const String kUnauthenticated = 'assets/images/indicators/unauthenticated.png';
  static const String kMarker = 'assets/images/markers/marker.png';
  static const String kUserMarker = 'assets/images/markers/user.png';
  static const String kError = 'assets/images/indicators/error.png';
  static const String kEmpty = 'assets/images/indicators/empty.png';
  static const String kLoading = 'assets/images/indicators/loading.png';
  static const String kMessage = 'assets/images/indicators/message.png';
  static const String kLocationError = 'assets/images/indicators/location_error.png';
}

class MapConfig {
  static const double kMinZoom = 10.0;
  static const double kMaxZoom = 19.0;
  static const double kDefaultZoom = 14.0;
  static const int kMaxRouteAccuracy = 1;
  static const int kMinRouteAccuracy = 15;
  static const double kRouteAccuracyZoomThreshold = 16.0;
}

class MapStyles {
  static const String kDark = 'mapbox/dark-v10';
  static const String kLight = 'mapbox/light-v10';
  static const String kStreets = 'mapbox/streets-v11';
  static const String kOutdoors = 'mapbox/outdoors-v11';
  static const String kSatellite = 'mapbox/satellite-v9';
}

class Distances {
  static const double kMinNearbyDistance = 50.0;
}

class NearbyMessageType {
  static const String kSos = 'sos';
  static const String kLocation = 'location';
  static const String kSeparator = '::';
}
