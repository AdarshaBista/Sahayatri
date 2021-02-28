class AppConfig {
  static const String appName = 'Sahayatri';
  static const String packageName = 'com.adrsh.sahayatri';
  static const String fontFamily = 'Sen';
  static const String fontFamilySerif = 'RobotoSlab';
}

class ApiConfig {
  static const int pageLimit = 10;
  static const int maxTags = 10;
  static const int maxImages = 10;
  static const int maxTextLength = 500;
  static const String apiBaseUrl = 'https://sahayatriapi.herokuapp.com/api/v1';
  static const String weatherApiBaseUrl =
      'https://api.openweathermap.org/data/2.5';
}

class UiConfig {
  static const double buttonHeight = 42.0;
  static const int animatorDuration = 500;
}

class ThemeStyles {
  static const String dark = 'dark';
  static const String light = 'light';
  static const String system = 'system';
}

class GpsAccuracy {
  static const String low = 'low';
  static const String high = 'high';
  static const String balanced = 'balanced';
}

class LocationConfig {
  static const int interval = 2000;
  static const double distanceFilter = 10.0;
  static const double minNearbyDistance = 50.0;
}

class MapConfig {
  static const double minZoom = 10.0;
  static const double maxZoom = 18.4;
  static const double defaultZoom = 14.0;
  static const double markerZoomThreshold = 13.0;
  static const int maxRouteAccuracy = 1;
  static const int minRouteAccuracy = 10;
  static const double routeAccuracyZoomThreshold = 16.0;
}

class DirectionsMode {
  static const String walk = 'walking';
  static const String drive = 'driving';
  static const String cycle = 'bicycling';
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
