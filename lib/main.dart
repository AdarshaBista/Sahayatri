import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sahayatri/core/models/prefs.dart';
import 'package:sahayatri/core/models/weather.dart';

import 'package:sahayatri/core/services/api_service.dart';
import 'package:sahayatri/core/services/location_service.dart';
import 'package:sahayatri/core/services/navigation_service.dart';
import 'package:sahayatri/core/services/notification_service.dart';

import 'package:sahayatri/app/database/prefs_dao.dart';
import 'package:sahayatri/app/database/weather_dao.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/sahayatri.dart';
import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  setStatusBarStyle();
  await initHive();
  runApp(const App());
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

Future<void> initHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  String hivePath;

  if (Platform.isWindows) {
    hivePath = 'db';
  } else {
    final appDir = await getApplicationDocumentsDirectory();
    hivePath = appDir.path;
  }

  Hive
    ..init(hivePath)
    ..registerAdapter(PrefsAdapter())
    ..registerAdapter(WeatherAdapter());
}

class App extends StatelessWidget {
  const App();

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: Platform.isWindows,
      style: DevicePreviewStyle(
        hasFrameShadow: true,
        background: const BoxDecoration(color: Color(0xFF24292E)),
        toolBar: DevicePreviewToolBarStyle.dark().copyWith(
          position: DevicePreviewToolBarPosition.left,
        ),
      ),
      data: const DevicePreviewData(deviceIndex: 11, isFrameVisible: true),
      builder: (_) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => ApiService()),
          RepositoryProvider(create: (_) => RootNavService()),
          RepositoryProvider(create: (_) => DestinationNavService()),
          RepositoryProvider(create: (_) => PrefsDao()),
          RepositoryProvider(create: (_) => WeatherDao()),
          RepositoryProvider(create: (_) => LocationService()),
          RepositoryProvider(create: (_) => NotificationService()),
        ],
        child: const Sahayatri(),
      ),
    );
  }
}
