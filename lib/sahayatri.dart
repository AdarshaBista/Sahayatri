import 'package:flutter/material.dart';

import 'package:sahayatri/core/services/api_service.dart';
import 'package:sahayatri/core/services/sms_service.dart';
import 'package:sahayatri/core/services/nearby_service.dart';
import 'package:sahayatri/core/services/weather_service.dart';
import 'package:sahayatri/core/services/tracker_service.dart';
import 'package:sahayatri/core/services/location_service.dart';
import 'package:sahayatri/core/services/directions_service.dart';
import 'package:sahayatri/core/services/navigation_service.dart';
import 'package:sahayatri/core/services/notification_service.dart';
import 'package:sahayatri/core/services/offroute_alert_service.dart';

import 'package:sahayatri/app/constants/configs.dart';
import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/app/routers/root_router.dart';

import 'package:sahayatri/app/database/prefs_dao.dart';
import 'package:sahayatri/app/database/weather_dao.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';
import 'package:sahayatri/ui/shared/widgets/splash_view.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:device_preview/device_preview.dart';

class Sahayatri extends StatelessWidget {
  const Sahayatri();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
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
      ],
      child: Builder(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<PrefsBloc>(
              create: (context) => PrefsBloc(
                prefsDao: context.repository<PrefsDao>(),
              )..initPrefs(),
            ),
            BlocProvider<NearbyCubit>(
              create: (context) => NearbyCubit(
                nearbyService: context.repository<NearbyService>(),
              ),
            ),
          ],
          child: const _App(),
        ),
      ),
    );
  }
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrefsBloc, PrefsState>(
      builder: (context, state) {
        if (state is PrefsLoading) {
          return const SplashView();
        }

        return MaterialApp(
          builder: DevicePreview.appBuilder,
          locale: DevicePreview.of(context).locale,
          debugShowCheckedModeBanner: false,
          title: AppConfig.kAppName,
          theme: AppThemes.light,
          navigatorKey: context.repository<RootNavService>().navigatorKey,
          initialRoute: Routes.kAuthPageRoute,
          onGenerateRoute: RootRouter.onGenerateRoute,
        );
      },
    );
  }
}
