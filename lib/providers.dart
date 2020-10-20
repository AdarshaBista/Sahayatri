import 'package:flutter/material.dart';

import 'package:sahayatri/core/services/api_service.dart';
import 'package:sahayatri/core/services/tts_service.dart';
import 'package:sahayatri/core/services/sms_service.dart';
import 'package:sahayatri/core/services/auth_service.dart';
import 'package:sahayatri/core/services/weather_service.dart';
import 'package:sahayatri/core/services/tracker_service.dart';
import 'package:sahayatri/core/services/location_service.dart';
import 'package:sahayatri/core/services/translate_service.dart';
import 'package:sahayatri/core/services/directions_service.dart';
import 'package:sahayatri/core/services/navigation_service.dart';
import 'package:sahayatri/core/services/destinations_service.dart';
import 'package:sahayatri/core/services/notification_service.dart';
import 'package:sahayatri/core/services/nearby/nearby_service.dart';
import 'package:sahayatri/core/services/offroute_alert_service.dart';

import 'package:sahayatri/app/database/user_dao.dart';
import 'package:sahayatri/app/database/prefs_dao.dart';
import 'package:sahayatri/app/database/weather_dao.dart';
import 'package:sahayatri/app/database/itinerary_dao.dart';
import 'package:sahayatri/app/database/destination_dao.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Providers {
  static List<RepositoryProvider> getProvidersWithoutDependencies() => [
        RepositoryProvider(create: (_) => UserDao()),
        RepositoryProvider(create: (_) => PrefsDao()),
        RepositoryProvider(create: (_) => WeatherDao()),
        RepositoryProvider(create: (_) => TtsService()),
        RepositoryProvider(create: (_) => ApiService()),
        RepositoryProvider(create: (_) => AuthService()),
        RepositoryProvider(create: (_) => ItineraryDao()),
        RepositoryProvider(create: (_) => RootNavService()),
        RepositoryProvider(create: (_) => DestinationDao()),
        RepositoryProvider(create: (_) => LocationService()),
        RepositoryProvider(create: (_) => TranslateService()),
        RepositoryProvider(create: (_) => NotificationService()),
        RepositoryProvider(create: (_) => DestinationNavService()),
      ];

  static List<RepositoryProvider> getProvidersWithDependencies(BuildContext context) => [
        RepositoryProvider<WeatherService>(
          create: (context) => WeatherService(
            apiService: context.repository<ApiService>(),
            weatherDao: context.repository<WeatherDao>(),
          ),
        ),
        RepositoryProvider<DirectionsService>(
          create: (context) => DirectionsService(
            locationService: context.repository<LocationService>(),
          ),
        ),
        RepositoryProvider<OffRouteAlertService>(
          create: (context) => OffRouteAlertService(
            notificationService: context.repository<NotificationService>(),
          ),
        ),
        RepositoryProvider<SmsService>(
          create: (context) => SmsService(
            prefsDao: context.repository<PrefsDao>(),
            notificationService: context.repository<NotificationService>(),
          ),
        ),
        RepositoryProvider<NearbyService>(
          create: (context) => NearbyService(
            notificationService: context.repository<NotificationService>(),
          ),
        ),
        RepositoryProvider<TrackerService>(
          create: (context) => TrackerService(
            locationService: context.repository<LocationService>(),
          ),
        ),
        RepositoryProvider<DestinationsService>(
          create: (context) => DestinationsService(
            apiService: context.repository<ApiService>(),
            destinationDao: context.repository<DestinationDao>(),
          ),
        ),
      ];
}
