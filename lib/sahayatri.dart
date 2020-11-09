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
            title: AppConfig.appName,
            builder: DevicePreview.appBuilder,
            locale: DevicePreview.of(context).locale,
            onGenerateRoute: RootRouter.onGenerateRoute,
            navigatorKey: context.watch<RootNavService>().navigatorKey,
            home: BlocBuilder<PrefsCubit, PrefsState>(
              builder: (context, state) {
                if (state is PrefsLoading) {
                  return const SplashView();
                }

                return FutureBuilder(
                  future: context.watch<UserCubit>().isLoggedIn(),
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
            apiService: context.read<ApiService>(),
            weatherDao: context.read<WeatherDao>(),
          ),
        ),
        RepositoryProvider<DirectionsService>(
          create: (context) => DirectionsService(
            locationService: context.read<LocationService>(),
          ),
        ),
        RepositoryProvider<OffRouteAlertService>(
          create: (context) => OffRouteAlertService(
            notificationService: context.read<NotificationService>(),
          ),
        ),
        RepositoryProvider<SmsService>(
          create: (context) => SmsService(
            prefsDao: context.read<PrefsDao>(),
            notificationService: context.read<NotificationService>(),
          ),
        ),
        RepositoryProvider<NearbyService>(
          create: (context) => NearbyService(
            notificationService: context.read<NotificationService>(),
          ),
        ),
        RepositoryProvider<TrackerService>(
          create: (context) => TrackerService(
            locationService: context.read<LocationService>(),
          ),
        ),
        RepositoryProvider<DestinationsService>(
          create: (context) => DestinationsService(
            apiService: context.read<ApiService>(),
            destinationDao: context.read<DestinationDao>(),
          ),
        ),
      ];

  List<BlocProvider> _getBlocProviders(BuildContext context) {
    return [
      BlocProvider<PrefsCubit>(
        create: (context) => PrefsCubit(
          prefsDao: context.read<PrefsDao>(),
        )..initPrefs(),
      ),
      BlocProvider<UserCubit>(
        create: (context) => UserCubit(
          userDao: context.read<UserDao>(),
          apiService: context.read<ApiService>(),
          authService: context.read<AuthService>(),
        ),
      ),
      BlocProvider<NearbyCubit>(
        create: (context) => NearbyCubit(
          nearbyService: context.read<NearbyService>(),
        ),
      ),
      BlocProvider<TranslateCubit>(
        create: (context) => TranslateCubit(
          ttsService: context.read<TtsService>(),
          translateService: context.read<TranslateService>(),
        ),
      ),
    ];
  }
}
