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
  locator
    // Daos
    ..registerLazySingleton<UserDao>(() => UserDao())
    ..registerLazySingleton<WeatherDao>(() => WeatherDao())

    // Services
    ..registerLazySingleton<TtsService>(() => TtsService())
    ..registerLazySingleton<ApiService>(() => ApiService())
    ..registerLazySingleton<SmsService>(() => SmsService())
    ..registerLazySingleton<AuthService>(() => AuthService())
    ..registerLazySingleton<NearbyService>(() => NearbyService())
    ..registerLazySingleton<WeatherService>(() => WeatherService())
    ..registerLazySingleton<TrackerService>(() => TrackerService())
    ..registerLazySingleton<RootNavService>(() => RootNavService())
    ..registerLazySingleton<LocationService>(() => LocationService())
    ..registerLazySingleton<StopwatchService>(() => StopwatchService())
    ..registerLazySingleton<TranslateService>(() => TranslateService())
    ..registerLazySingleton<DirectionsService>(() => DirectionsService())
    ..registerLazySingleton<DestinationsService>(() => DestinationsService())
    ..registerLazySingleton<NotificationService>(() => NotificationService())
    ..registerLazySingleton<OffRouteAlertService>(() => OffRouteAlertService())
    ..registerLazySingleton<DestinationNavService>(() => DestinationNavService());
}

void setupUserDependentDaos(String userId) {
  locator
    ..registerLazySingleton<PrefsDao>(() => PrefsDao(userId))
    ..registerLazySingleton<TrackerDao>(() => TrackerDao(userId))
    ..registerLazySingleton<ItineraryDao>(() => ItineraryDao(userId))
    ..registerLazySingleton<DestinationDao>(() => DestinationDao(userId));
}
