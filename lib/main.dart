import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
import 'package:sahayatri/core/services/tracker_service/tracker_service.dart';
import 'package:sahayatri/core/services/tracker_service/mock_tracker_service.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  setStatusBarStyle();
  runApp(
    DevicePreview(
      enabled: Platform.isWindows,
      style: DevicePreviewStyle(
        background: const BoxDecoration(color: Color(0xFF24292E)),
        toolBar: DevicePreviewToolBarStyle.dark().copyWith(
          position: DevicePreviewToolBarPosition.left,
        ),
      ),
      data: const DevicePreviewData(deviceIndex: 11, isFrameVisible: true),
      builder: (_) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => ApiService()),
          RepositoryProvider(create: (_) => LocationService()),
          RepositoryProvider(create: (_) => RootNavService()),
          RepositoryProvider(create: (_) => DestinationNavService()),
        ],
        child: Sahayatri(),
      ),
    ),
  );
}

void setStatusBarStyle() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

class Sahayatri extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WeatherService>(
          create: (_) => WeatherService(
            apiService: context.repository<ApiService>(),
          ),
        ),
        RepositoryProvider<TrackerService>(
          create: (_) => MockTrackerService(),
        ),
        RepositoryProvider<DirectionsService>(
          create: (_) => DirectionsService(
            locationService: context.repository<LocationService>(),
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
