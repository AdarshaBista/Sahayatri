import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sahayatri/providers.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/prefs.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/review.dart';
import 'package:sahayatri/core/models/weather.dart';
import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/review_details.dart';
import 'package:sahayatri/core/models/lodge_facility.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/sahayatri.dart';
import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  setStatusBarStyle();
  await initHive();
  runApp(const App());
}

class App extends StatelessWidget {
  const App();

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: Platform.isWindows,
      onScreenshot: (ss) async {
        final dir = await getDownloadsDirectory();
        final fileName = DateTime.now().microsecondsSinceEpoch;
        final savePath = '${dir.path}/$fileName.png';
        await File(savePath).writeAsBytes(ss.bytes);

        print('Saved image as $savePath');
        return savePath;
      },
      style: DevicePreviewStyle(
        hasFrameShadow: false,
        background: const BoxDecoration(color: Color(0xFF24292E)),
        toolBar: DevicePreviewToolBarStyle.dark(
          position: DevicePreviewToolBarPosition.left,
        ),
      ),
      data: const DevicePreviewData(
        deviceIndex: 11,
        isDarkMode: true,
      ),
      builder: (_) => MultiRepositoryProvider(
        providers: Providers.getProvidersWithoutDependencies(),
        child: const Sahayatri(),
      ),
    );
  }
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
  final appDir = await getApplicationDocumentsDirectory();
  final hivePath = '${appDir.path}/${AppConfig.kAppName}';

  Hive
    ..init(hivePath)
    ..registerAdapter(UserAdapter())
    ..registerAdapter(PrefsAdapter())
    ..registerAdapter(CoordAdapter())
    ..registerAdapter(LodgeAdapter())
    ..registerAdapter(PlaceAdapter())
    ..registerAdapter(ReviewAdapter())
    ..registerAdapter(WeatherAdapter())
    ..registerAdapter(ItineraryAdapter())
    ..registerAdapter(CheckpointAdapter())
    ..registerAdapter(DestinationAdapter())
    ..registerAdapter(ReviewDetailsAdapter())
    ..registerAdapter(LodgeFacilityAdapter());
}
