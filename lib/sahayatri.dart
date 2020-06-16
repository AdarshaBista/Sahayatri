import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/values.dart';
import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/app/routers/root_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/prefs_bloc/prefs_bloc.dart';

import 'package:sahayatri/core/services/api_service.dart';
import 'package:sahayatri/core/services/weather_service.dart';
import 'package:sahayatri/core/services/location_service.dart';
import 'package:sahayatri/core/services/directions_service.dart';
import 'package:sahayatri/core/services/navigation_service.dart';
import 'package:sahayatri/core/services/user_alert_service.dart';
import 'package:sahayatri/core/services/tracker_service/tracker_service.dart';
import 'package:sahayatri/core/services/tracker_service/mock_tracker_service.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:device_preview/device_preview.dart';

class Sahayatri extends StatelessWidget {
  const Sahayatri();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WeatherService>(
          create: (_) => WeatherService(
            apiService: context.repository<ApiService>(),
          ),
        ),
        RepositoryProvider<DirectionsService>(
          create: (_) => DirectionsService(
            locationService: context.repository<LocationService>(),
          ),
        ),
        RepositoryProvider<TrackerService>(
          create: (_) => MockTrackerService(
            userAlertService: context.repository<UserAlertService>(),
          ),
        ),
      ],
      child: BlocProvider<PrefsBloc>(
        create: (_) => PrefsBloc(),
        child: MaterialApp(
          builder: DevicePreview.appBuilder,
          locale: DevicePreview.of(context).locale,
          debugShowCheckedModeBanner: false,
          title: Values.kAppName,
          theme: AppThemes.light,
          navigatorKey: context.repository<RootNavService>().navigatorKey,
          initialRoute: Routes.kBottomNavPageRoute,
          onGenerateRoute: RootRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
