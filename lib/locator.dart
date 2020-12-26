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

void registerGlobalServices() {
  locator
    // Daos
    ..registerLazySingleton<UserDao>(() => UserDao())
    ..registerLazySingleton<WeatherDao>(() => WeatherDao())

    // Services
    ..registerLazySingleton<ApiService>(() => ApiService())
    ..registerLazySingleton<AuthService>(() => AuthService())
    ..registerLazySingleton<RootNavService>(() => RootNavService())
    ..registerLazySingleton<WeatherService>(() => WeatherService())
    ..registerLazySingleton<LocationService>(() => LocationService())
    ..registerLazySingleton<DirectionsService>(() => DirectionsService())
    ..registerLazySingleton<DestinationsService>(() => DestinationsService())
    ..registerLazySingleton<DestinationNavService>(() => DestinationNavService());
}

void registerUserDependentServices(String userId) {
  locator
    // Daos
    ..registerLazySingleton<PrefsDao>(() => PrefsDao(userId))
    ..registerLazySingleton<TrackerDao>(() => TrackerDao(userId))
    ..registerLazySingleton<ItineraryDao>(() => ItineraryDao(userId))
    ..registerLazySingleton<DestinationDao>(() => DestinationDao(userId))

    // Services
    ..registerLazySingleton<TtsService>(() => TtsService())
    ..registerLazySingleton<SmsService>(() => SmsService())
    ..registerLazySingleton<NearbyService>(() => NearbyService())
    ..registerLazySingleton<TrackerService>(() => TrackerService())
    ..registerLazySingleton<TranslateService>(() => TranslateService())
    ..registerLazySingleton<StopwatchService>(() => StopwatchService())
    ..registerLazySingleton<NotificationService>(() => NotificationService())
    ..registerLazySingleton<OffRouteAlertService>(() => OffRouteAlertService());
}

void unregisterUserDependentServices() {
  locator
    // Daos
    ..unregister<PrefsDao>()
    ..unregister<TrackerDao>()
    ..unregister<ItineraryDao>()
    ..unregister<DestinationDao>()

    // Services
    ..unregister<TtsService>()
    ..unregister<TranslateService>()
    ..unregister<StopwatchService>()
    ..unregister<NotificationService>()
    ..unregister<OffRouteAlertService>()
    ..unregister<SmsService>(disposingFunction: (service) => service.stop())
    ..unregister<NearbyService>(disposingFunction: (service) async => service.stop())
    ..unregister<TrackerService>(disposingFunction: (service) async => service.stop());
}
