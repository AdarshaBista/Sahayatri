import 'package:get_it/get_it.dart';

import 'package:sahayatri/core/services/api_service.dart';
import 'package:sahayatri/core/services/auth_service.dart';
import 'package:sahayatri/core/services/destinations_service.dart';
import 'package:sahayatri/core/services/directions_service.dart';
import 'package:sahayatri/core/services/location/gps_location_service.dart';
import 'package:sahayatri/core/services/location/location_service.dart';
import 'package:sahayatri/core/services/location/mock_location_service.dart';
import 'package:sahayatri/core/services/navigation_service.dart';
import 'package:sahayatri/core/services/nearby/nearby_service.dart';
import 'package:sahayatri/core/services/notification_service.dart';
import 'package:sahayatri/core/services/offroute_alert_service.dart';
import 'package:sahayatri/core/services/tracker/stopwatch_service.dart';
import 'package:sahayatri/core/services/tracker/tracker_service.dart';
import 'package:sahayatri/core/services/translate_service.dart';
import 'package:sahayatri/core/services/tts_service.dart';
import 'package:sahayatri/core/services/weather_service.dart';

import 'package:sahayatri/app/database/destination_dao.dart';
import 'package:sahayatri/app/database/itinerary_dao.dart';
import 'package:sahayatri/app/database/prefs_dao.dart';
import 'package:sahayatri/app/database/tracker_dao.dart';
import 'package:sahayatri/app/database/user_dao.dart';
import 'package:sahayatri/app/database/weather_dao.dart';

GetIt locator = GetIt.instance;

Future<void> registerGlobalServices() async {
  try {
    locator
      // Daos
      ..registerLazySingleton<UserDao>(() => UserDao())
      ..registerLazySingleton<WeatherDao>(() => WeatherDao())

      // Services
      ..registerLazySingleton<ApiService>(() => ApiService())
      ..registerLazySingleton<AuthService>(() => AuthService())
      ..registerLazySingleton<RootNavService>(() => RootNavService())
      ..registerLazySingleton<WeatherService>(() => WeatherService())
      ..registerLazySingleton<DirectionsService>(() => DirectionsService())
      ..registerLazySingleton<DestinationsService>(() => DestinationsService())
      ..registerLazySingleton<DestinationNavService>(() => DestinationNavService());

    await locator.allReady();
  } catch (e) {
    print(e.toString());
  }
}

Future<void> registerUserDependentServices(String userId) async {
  try {
    locator
      // Daos
      ..registerLazySingleton<PrefsDao>(() => PrefsDao(userId))
      ..registerLazySingleton<TrackerDao>(() => TrackerDao(userId))
      ..registerLazySingleton<ItineraryDao>(() => ItineraryDao(userId))
      ..registerLazySingleton<DestinationDao>(() => DestinationDao(userId))

      // Services
      ..registerLazySingleton<TtsService>(() => TtsService())
      ..registerLazySingleton<NearbyService>(() => NearbyService())
      ..registerLazySingleton<TrackerService>(() => TrackerService())
      ..registerLazySingleton<TranslateService>(() => TranslateService())
      ..registerLazySingleton<StopwatchService>(() => StopwatchService())
      ..registerLazySingleton<NotificationService>(() => NotificationService())
      ..registerLazySingleton<OffRouteAlertService>(() => OffRouteAlertService())
      ..registerLazySingleton<LocationService>(() => GpsLocationService())
      ..registerLazySingleton<LocationService>(
        () => MockLocationService(),
        instanceName: 'mock',
      );

    await locator.allReady();
  } catch (e) {
    print(e.toString());
  }
}

Future<void> unregisterUserDependentServices() async {
  try {
    locator
      // Daos
      ..unregister<PrefsDao>()
      ..unregister<TrackerDao>()
      ..unregister<ItineraryDao>()
      ..unregister<DestinationDao>()

      // Services
      ..unregister<TtsService>()
      ..unregister<LocationService>()
      ..unregister<LocationService>(instanceName: 'mock')
      ..unregister<TranslateService>()
      ..unregister<StopwatchService>()
      ..unregister<NotificationService>()
      ..unregister<OffRouteAlertService>()
      ..unregister<NearbyService>(
        disposingFunction: (service) async => service.stop(),
      )
      ..unregister<TrackerService>(
        disposingFunction: (service) async => service.stop(),
      );

    await locator.allReady();
  } catch (e) {
    print(e.toString());
  }
}
