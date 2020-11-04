class AppConfig {
  static const String appName = 'Sahayatri';
  static const String packageName = 'com.adrsh.sahayatri';
  static const String fontFamily = 'Sen';
  static const String fontFamilySerif = 'RobotoSlab';
  static const String smsMessagePrefix = 'I have safely reached';
}

class ApiConfig {
  static const int pageLimit = 10;
  static const int maxImages = 12;
  static const int maxTextLength = 500;
  static const String apiBaseUrl = 'https://sahayatriapi.herokuapp.com/api/v1';
  static const String weatherApiBaseUrl = 'https://api.openweathermap.org/data/2.5';
}

class UiConfig {
  static const int animatorDuration = 500;
  static const double trackerPanelHeight = 90.0;
  static const double profileHeaderHeight = 290.0;
}

class Images {
  static const String splash = 'assets/icons/splash.png';
  static const String authBackground = 'assets/images/backgrounds/auth.png';
  static const String unauthenticated = 'assets/images/indicators/unauthenticated.png';
  static const String marker = 'assets/images/markers/marker.png';
  static const String userMarker = 'assets/images/markers/user.png';
  static const String error = 'assets/images/indicators/error.png';
  static const String empty = 'assets/images/indicators/empty.png';
  static const String loading = 'assets/images/indicators/loading.png';
  static const String message = 'assets/images/indicators/message.png';
  static const String downloaded = 'assets/images/indicators/downloaded.png';
  static const String locationError = 'assets/images/indicators/location_error.png';
}

class LocationConfig {
  static const int interval = 2000;
  static const double distanceFilter = 10.0;
  static const double minNearbyDistance = 50.0;
}

class MapConfig {
  static const double minZoom = 10.0;
  static const double maxZoom = 19.0;
  static const double defaultZoom = 14.0;
  static const int maxRouteAccuracy = 1;
  static const int minRouteAccuracy = 15;
  static const double routeAccuracyZoomThreshold = 16.0;
}

class MapStyles {
  static const String dark = 'mapbox/dark-v10';
  static const String light = 'mapbox/light-v10';
  static const String streets = 'mapbox/streets-v11';
  static const String outdoors = 'mapbox/outdoors-v11';
  static const String satellite = 'mapbox/satellite-v9';
}

class NearbyMessageType {
  static const String sos = 'sos';
  static const String location = 'location';
  static const String separator = '::';
}
