import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user.dart';

import 'package:sahayatri/core/services/api_service.dart';
import 'package:sahayatri/core/services/tts_service.dart';
import 'package:sahayatri/core/services/sms_service.dart';
import 'package:sahayatri/core/services/auth_service.dart';
import 'package:sahayatri/core/services/weather_service.dart';
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

import 'package:sahayatri/app/constants/configs.dart';
import 'package:sahayatri/app/routers/root_router.dart';

import 'package:sahayatri/app/database/user_dao.dart';
import 'package:sahayatri/app/database/prefs_dao.dart';
import 'package:sahayatri/app/database/tracker_dao.dart';
import 'package:sahayatri/app/database/weather_dao.dart';
import 'package:sahayatri/app/database/itinerary_dao.dart';
import 'package:sahayatri/app/database/destination_dao.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/theme_cubit/theme_cubit.dart';
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
      providers: [
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
            trackerDao: context.read<TrackerDao>(),
            notificationService: context.read<NotificationService>(),
          ),
        ),
        RepositoryProvider<NearbyService>(
          create: (context) => NearbyService(
            notificationService: context.read<NotificationService>(),
          ),
        ),
        RepositoryProvider<StopwatchService>(
          create: (context) => StopwatchService(
            trackerDao: context.read<TrackerDao>(),
          ),
        ),
        RepositoryProvider<TrackerService>(
          create: (context) => TrackerService(
            locationService: context.read<LocationService>(),
            stopwatchService: context.read<StopwatchService>(),
          ),
        ),
        RepositoryProvider<DestinationsService>(
          create: (context) => DestinationsService(
            apiService: context.read<ApiService>(),
            destinationDao: context.read<DestinationDao>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ThemeCubit(),
          ),
          BlocProvider<PrefsCubit>(
            create: (context) => PrefsCubit(
              prefsDao: context.read<PrefsDao>(),
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
          BlocProvider<UserCubit>(
            create: (context) => UserCubit(
              userDao: context.read<UserDao>(),
              apiService: context.read<ApiService>(),
              authService: context.read<AuthService>(),
              onAuthenticated: (user) => onAuthenticated(context, user),
            )..isLoggedIn(),
          ),
        ],
        child: _buildApp(),
      ),
    );
  }

  Widget _buildApp() {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          title: AppConfig.appName,
          builder: DevicePreview.appBuilder,
          locale: DevicePreview.locale(context),
          onGenerateRoute: RootRouter.onGenerateRoute,
          navigatorKey: RepositoryProvider.of<RootNavService>(context).navigatorKey,
          home: _buildUserState(),
        );
      },
    );
  }

  Widget _buildUserState() {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return _buildPrefsState(context, state);
        } else if (state is AuthLoading) {
          return const SplashView();
        } else {
          return const AuthPage();
        }
      },
    );
  }

  Widget _buildPrefsState(BuildContext context, Authenticated state) {
    return BlocBuilder<PrefsCubit, PrefsState>(
      builder: (context, state) {
        if (state is PrefsLoaded) {
          return const HomePage();
        }
        return const SplashView();
      },
    );
  }

  void onAuthenticated(BuildContext context, User user) {
    RepositoryProvider.of<PrefsDao>(context).init(user.id);
    RepositoryProvider.of<TrackerDao>(context).init(user.id);
    RepositoryProvider.of<ItineraryDao>(context).init(user.id);
    RepositoryProvider.of<DestinationDao>(context).init(user.id);

    final prefsCubit = BlocProvider.of<PrefsCubit>(context);
    prefsCubit.initPrefs().then((_) {
      final prefs = prefsCubit.prefs;
      BlocProvider.of<ThemeCubit>(context).init(prefs.theme);
    });
  }
}
