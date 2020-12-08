import 'package:get_it/get_it.dart';

import 'package:sahayatri/core/services/api_service.dart';
import 'package:sahayatri/core/services/tts_service.dart';
import 'package:sahayatri/core/services/sms_service.dart';
import 'package:sahayatri/core/services/auth_service.dart';
import 'package:sahayatri/core/services/location_service.dart';
import 'package:sahayatri/core/services/translate_service.dart';
import 'package:sahayatri/core/services/directions_service.dart';
import 'package:sahayatri/core/services/navigation_service.dart';
import 'package:sahayatri/core/services/destinations_service.dart';
import 'package:sahayatri/core/services/notification_service.dart';
import 'package:sahayatri/core/services/nearby/nearby_service.dart';
import 'package:sahayatri/core/services/offroute_alert_service.dart';
import 'package:sahayatri/core/services/tracker/tracker_service.dart';
import 'package:sahayatri/core/services/tracker/stopwatch_service.dart';

import 'package:sahayatri/app/database/user_dao.dart';
import 'package:sahayatri/app/database/prefs_dao.dart';
import 'package:sahayatri/app/database/weather_dao.dart';
import 'package:sahayatri/app/database/tracker_dao.dart';
import 'package:sahayatri/app/database/itinerary_dao.dart';
import 'package:sahayatri/app/database/destination_dao.dart';
import 'package:sahayatri/core/services/weather_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Daos
  locator.registerLazySingleton<UserDao>(() => UserDao());
  locator.registerLazySingleton<PrefsDao>(() => PrefsDao());
  locator.registerLazySingleton<TrackerDao>(() => TrackerDao());
  locator.registerLazySingleton<WeatherDao>(() => WeatherDao());
  locator.registerLazySingleton<ItineraryDao>(() => ItineraryDao());
  locator.registerLazySingleton<DestinationDao>(() => DestinationDao());

  // Services
  locator.registerLazySingleton<TtsService>(() => TtsService());
  locator.registerLazySingleton<ApiService>(() => ApiService());
  locator.registerLazySingleton<SmsService>(() => SmsService());
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<NearbyService>(() => NearbyService());
  locator.registerLazySingleton<WeatherService>(() => WeatherService());
  locator.registerLazySingleton<TrackerService>(() => TrackerService());
  locator.registerLazySingleton<RootNavService>(() => RootNavService());
  locator.registerLazySingleton<LocationService>(() => LocationService());
  locator.registerLazySingleton<StopwatchService>(() => StopwatchService());
  locator.registerLazySingleton<TranslateService>(() => TranslateService());
  locator.registerLazySingleton<DirectionsService>(() => DirectionsService());
  locator.registerLazySingleton<DestinationsService>(() => DestinationsService());
  locator.registerLazySingleton<NotificationService>(() => NotificationService());
  locator.registerLazySingleton<OffRouteAlertService>(() => OffRouteAlertService());
  locator.registerLazySingleton<DestinationNavService>(() => DestinationNavService());
}
