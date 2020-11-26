class AppConfig {
  static const String appName = 'Sahayatri';
  static const String packageName = 'com.adrsh.sahayatri';
  static const String fontFamily = 'Sen';
  static const String fontFamilySerif = 'RobotoSlab';
  static const String smsMessagePrefix = 'I have safely reached';
}

class ApiConfig {
  static const int maxTags = 10;
  static const int pageLimit = 10;
  static const int maxImages = 10;
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
  static const String marker = 'assets/images/markers/marker.png';
  static const String userMarker = 'assets/images/markers/user.png';
  static const String authBackground = 'assets/images/backgrounds/auth.png';

  static const String alert = 'assets/images/indicators/alert.png';
  static const String unauthenticated = 'assets/images/indicators/unauthenticated.png';
  static const String generalEmpty = 'assets/images/indicators/general_empty.png';
  static const String generalError = 'assets/images/indicators/general_error.png';
  static const String generalLoading = 'assets/images/indicators/general_loading.png';
  static const String downloadLoading = 'assets/images/indicators/download_loading.png';
  static const String downloadComplete = 'assets/images/indicators/download_complete.png';
  static const String imagesEmpty = 'assets/images/indicators/images_empty.png';
  static const String searchEmpty = 'assets/images/indicators/search_empty.png';
  static const String translationEmpty = 'assets/images/indicators/translation_empty.png';
  static const String weatherError = 'assets/images/indicators/weather_error.png';
  static const String weatherLoading = 'assets/images/indicators/weather_loading.png';
  static const String trackerError = 'assets/images/indicators/tracker_error.png';
  static const String trackerLoading = 'assets/images/indicators/tracker_loading.png';
  static const String trackerUnavailable =
      'assets/images/indicators/tracker_unavailable.png';
  static const String destinationsEmpty =
      'assets/images/indicators/destinations_empty.png';
  static const String destinationsError =
      'assets/images/indicators/destinations_error.png';
  static const String destinationsLoading =
      'assets/images/indicators/destinations_loading.png';
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
