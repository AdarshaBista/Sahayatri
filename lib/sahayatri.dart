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

import 'package:sahayatri/app/constants/configs.dart';
import 'package:sahayatri/app/routers/root_router.dart';

import 'package:sahayatri/app/database/user_dao.dart';
import 'package:sahayatri/app/database/prefs_dao.dart';
import 'package:sahayatri/app/database/weather_dao.dart';
import 'package:sahayatri/app/database/destination_dao.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';
import 'package:sahayatri/cubits/translate_cubit/translate_cubit.dart';

import 'package:device_preview/device_preview.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/splash_view.dart';

import 'package:sahayatri/ui/pages/auth_page/auth_page.dart';
import 'package:sahayatri/ui/pages/home_page/home_page.dart';

class Sahayatri extends StatelessWidget {
  const Sahayatri();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: _getServiceProviders(context),
      child: Builder(
        builder: (context) => MultiBlocProvider(
          providers: _getBlocProviders(context),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppThemes.light,
            title: AppConfig.kAppName,
            builder: DevicePreview.appBuilder,
            locale: DevicePreview.of(context).locale,
            onGenerateRoute: RootRouter.onGenerateRoute,
            navigatorKey: context.repository<RootNavService>().navigatorKey,
            home: BlocBuilder<PrefsCubit, PrefsState>(
              builder: (context, state) {
                if (state is PrefsLoading) {
                  return const SplashView();
                }

                return FutureBuilder(
                  future: context.bloc<UserCubit>().isLoggedIn(),
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData) {
                      final bool isLoggedIn = snapshot.data;
                      if (isLoggedIn) return const HomePage();
                      return const AuthPage();
                    }
                    return const SplashView();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<RepositoryProvider> _getServiceProviders(BuildContext context) => [
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

  List<BlocProvider> _getBlocProviders(BuildContext context) {
    return [
      BlocProvider<PrefsCubit>(
        create: (context) => PrefsCubit(
          prefsDao: context.repository<PrefsDao>(),
        )..initPrefs(),
      ),
      BlocProvider<UserCubit>(
        create: (context) => UserCubit(
          userDao: context.repository<UserDao>(),
          apiService: context.repository<ApiService>(),
          authService: context.repository<AuthService>(),
        ),
      ),
      BlocProvider<NearbyCubit>(
        create: (context) => NearbyCubit(
          nearbyService: context.repository<NearbyService>(),
        ),
      ),
      BlocProvider<TranslateCubit>(
        create: (context) => TranslateCubit(
          ttsService: context.repository<TtsService>(),
          translateService: context.repository<TranslateService>(),
        ),
      ),
    ];
  }
}
